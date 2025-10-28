terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }

  required_version = ">= 1.6.0"
}

provider "aws" {
  region = var.aws_region
}

# 1. VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# 2. Public Subnet 1
resource "aws_subnet" "public_1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_1_cidr
  availability_zone = var.public_subnet_1_az
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_1_name
  }
}

# 3. Public Subnet 2
resource "aws_subnet" "public_2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_2_cidr
  availability_zone = var.public_subnet_2_az
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_2_name
  }
}

# 4. Private Subnet 1
resource "aws_subnet" "private_1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_1_cidr
  availability_zone = var.private_subnet_1_az
  map_public_ip_on_launch = false

  tags = {
    Name = var.private_subnet_1_name
  }
}

# 5. Private Subnet 2
resource "aws_subnet" "private_2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_2_cidr
  availability_zone = var.private_subnet_2_az
  map_public_ip_on_launch = false

  tags = {
    Name = var.private_subnet_2_name
  }
}

# 6. Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = var.igw_name
  }
}

# 7. Elastic IP for NAT
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = var.nat_name
  }
}

# NAT Gateway in Public Subnet 1
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.public_1.id
  depends_on = [ aws_internet_gateway.igw.id ]
  tags = {
    Name = var.nat_name
  }
}

# 8. Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.public_rt_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public_rt_name
  }
}

# 9. Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.private_rt_cidr
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = var.private_rt_name
  }
}

# 10. Public Route Table Association
resource "aws_route_table_association" "public_associate" {
  for_each = toset([
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ])
  subnet_id = each.value
  route_table_id = aws_route_table.public_rt.id
}

# 11. Private Route table Associaiton
resource "aws_route_table_association" "private_associate" {
  for_each = toset([
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ])
  subnet_id = each.value
  route_table_id = aws_route_table.private_rt.id
}

# 12. EC2 Security Group
resource "aws_security_group" "web_sg" {
  name = var.web_sg_name
  vpc_id = aws_vpc.main.id
  
  dynamic "ingress" {
    for_each = var.web_sg_ingress_rules
    content {
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.web_sg_egress_rules
    content {
      from_port = egress.value.from_port
      to_port = egress.value.to_port
      protocol = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

# 13. Find Latest ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# 14. Upload SSH Key to AWS
resource "aws_key_pair" "ec2_key" {
  key_name = var.ssh_key_name
  public_key = file(pathexpand(var.ssh_key_path))
}

# 15. Ec2 Instance
resource "aws_instance" "web" {
  ami = data.aws_ami.ubuntu
  instance_type = var.instance_type
  subnet_id = aws_subnet.public_1.id
  security_groups = [aws_security_group.web_sg.id]
  key_name = aws_key_pair.ec2_key.key_name

  user_data = templatefile("${path.module}/user-data.sh", {
    rds_endpoint = aws_db_instance.db.address
    github_token = var.github_token
})
  tags = {
    Name = var.ec2_name
  }
}

# 16. ALB Security Group
resource "aws_security_group" "alb_sg" {
  name = var.alb_sg_name
  vpc_id = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.alb_ingress_rules
    content {
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.alb_egress_rules
    content {
      from_port = egress.value.from_port
      to_port = egress.value.to_port
      protocol = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

# 17. Application Load Balancer
resource "aws_lb" "alb" {
  name = var.alb_name
  load_balancer_type = "application"
  internal = var.alb_is_internal
  subnets = [aws_subnet.public_1.id, aws_subnet.public_2.id]
  security_groups = [aws_security_group.alb_sg.id]
  enable_deletion_protection = var.enable_deletion_protection
}

# 18. Target Group
resource "aws_lb_target_group" "tg" {
  name = var.tg_name
  vpc_id = aws_vpc.main.id
  port = var.tg_port
  protocol = var.tg_protocol

  health_check {
    enabled = true
    port = "traffic-port"
    path = var.tg_health_check_path
    matcher = var.tg_health_check_matcher
  }
}

# 19. HTTPS Listener For ALB
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = var.alb_listener_port
  protocol = var.alb_listener_protocol
  ssl_policy = var.alb_ssl_policy
  certificate_arn = var.ssl_arn

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# 20. HTTP To HTTPS Redirect
resource "aws_lb_listener" "http_to_https" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port = 443
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# 21. Attach EC2 Instance to Target Group
resource "aws_lb_target_group_attachment" "tg_attach" {
  target_group_arn = aws_lb_target_group.target_group_arn
  target_id = aws_instance.web.id
  port = var.tg_port
}

# 22. DB Subnet Group
resource "aws_db_subnet_group" "rds_subnet" {
  name = var.db_subnet_group
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}

# 23. RDS Security Group
resource "aws_security_group" "db_sg" {
  name = var.db_sg_name
  vpc_id = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.db_sg_ingress_rules
    content {
      from_port = ingress.value.from_port
      to_port = ingress.vale.to_port
      protocol = ingress.value.protocol
      security_groups = [aws_security_group.web_sg]
    }
  }

  dynamic "egress" {
    for_each = var.db_sg_eggress_rules
    content {
      from_port = egress.value.from_port
      to_port = egress.value.to_port
      protocol = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

# 24. RDS Instance

resource "aws_db_instance" "db" {
    identifier = var.db_identifier
    db_name = var.db_name
    engine = "mysql"
    engine_version = "8.0"
    instance_class = var.db_instance_class
    allocated_storage = var.db_storage
    username = var.db_username
    password = var.db_password
    skip_final_snapshot = true
    publicly_accessible = false
    db_subnet_group_name = aws_db_subnet_group.rds_subnet.id
    vpc_security_group_ids = [aws_security_group.db_sg.id]
    multi_az = false
}