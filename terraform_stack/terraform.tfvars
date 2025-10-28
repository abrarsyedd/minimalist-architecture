aws_region = "us-east-1"
vpc_name = "minimalist_vpc"
vpc_cidr = "10.0.0.0/16"

public_subnet_1_name = "public_1"
public_subnet_1_cidr = "10.0.0.0/24"
public_subnet_1_az = "us-east-1a"

public_subnet_2_name = "public_2"
public_subnet_2_cidr = "10.0.1.0/24"
public_subnet_2_az = "us-east-1b"

private_subnet_1_name = "private_1"
private_subnet_1_cidr = "10.0.2.0/24"
private_subnet_1_az = "us-east-1a"

private_subnet_2_name = "private_2"
private_subnet_2_cidr = "10.0.3.0/24"
private_subnet_2_az = "us-east-1b"

igw_name = "IGW"
nat_name = "NAT"

public_rt_name = "public_rt"
public_rt_cidr = "0.0.0.0/0"

private_rt_name = "private_rt"
private_rt_cidr = "0.0.0.0/0"


web_sg_name = "miimalist_web_sg"
web_sg_ingress_rules = [ {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
},
{
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
} ]

web_sg_egress_rules = [ {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
} ]

ssh_key_name = "ec2-key"
ssh_key_path = "~/.ssh/ec2-key.pub"
ec2_name = "mninimalist-app"
instance_type = "t2.micro"

alb_sg_name = "alb_sg"
alb_ingress_rules = [ {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
},
{
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
} ]

alb_egress_rules = [ {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
} ]

alb_name = "minimalist-alb"
alb_is_internal = false
enable_deletion_protection = false

tg_name = "minimalist-tg"
tg_port = 3000
tg_protocol = "HTTP"
tg_health_check_path = "/"
tg_health_check_matcher = "200"

alb_listener_port = 443
alb_listener_protocol = "HTTPS"
alb_ssl_policy = "ELBSecurityPolicy-2016-08"

db_subnet_group = "minimalist-db-subnet"

db_sg_name = "db_sg"
db_sg_ingress_rules = [ {
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
} ]

db_sg_eggress_rules = [ {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
} ]

db_identifier = "minimalist-db"
db_name = "minimalist_architecture_db"
db_instance_class = "db.t3.micro"
db_storage = "10"
db_username = "admin"

