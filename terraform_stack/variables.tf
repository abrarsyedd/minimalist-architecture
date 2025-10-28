variable "aws_region" {
  description = "AWS Region"
  type = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type = string
}

variable "vpc_cidr" {
  description = "CIDR Block For VPC"
  type = string
}

variable "public_subnet_1_name" {
  description = "Name of the Public Subnet 1"
  type = string
}

variable "public_subnet_1_cidr" {
  description = "CIDR Block For Public Subnet 1"
  type = string
}

variable "public_subnet_1_az" {
  description = "AZ For Public Subnet 1"
}

variable "public_subnet_2_name" {
  description = "Name of the Public Subnet 2"
  type = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR Block For Public Subnet 2"
  type = string
}

variable "public_subnet_2_az" {
  description = "AZ For Public Subnet 2"
}

variable "private_subnet_1_name" {
  description = "Name of the Private Subnet 1"
  type = string
}

variable "private_subnet_1_cidr" {
  description = "CIDR Block For Private Subnet 1"
  type = string
}

variable "private_subnet_1_az" {
  description = "AZ For Private Subnet 1"
}

variable "private_subnet_2_name" {
  description = "Name of the Private Subnet 2"
  type = string
}

variable "private_subnet_2_cidr" {
  description = "CIDR Block For Private Subnet 2"
  type = string
}

variable "private_subnet_2_az" {
  description = "AZ For Private Subnet 2"
}

variable "igw_name" {
  description = "Name of the Internet Gateway"
  type = string
}

variable "nat_name" {
  description = "Name of the NAT Gateway"
  type = string
}

variable "public_rt_name" {
  description = "Name of the Public Route table"
  type = string
}

variable "public_rt_cidr" {
  description = "CIDR Block For Public Route Table"
  type = string
}

variable "private_rt_name" {
  description = "Name of the Private Route table"
  type = string
}

variable "private_rt_cidr" {
  description = "CIDR Block For Private Route Table"
  type = string
}

variable "web_sg_name" {
  description = "Name of the Web Security Group"
  type = string
}

variable "web_sg_ingress_rules" {
  description = "Inbound Rules For Web Security Group"
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string) 
  }))
}

variable "web_sg_egress_rules" {
  description = "Outbound Rules For Web Security Group"
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string) 
  }))
}

variable "ssh_key_name" {
  description = "Name of the SSH Key"
  type = string
}

variable "ssh_key_path" {
  description = "Path to SSH Key"
  type = string
}

variable "ec2_name" {
  description = "Name of the EC2 Instance"
  type = string
}

variable "instance_type" {
  description = "Type of EC2 Instance"
  type = string
}

variable "alb_sg_name" {
  description = "Name of the ALB Security Group"
  type = string
}

variable "alb_ingress_rules" {
  description = "Ibound Rules For ALB Security Group"
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)  
  }))
}

variable "alb_egress_rules" {
  description = "Outbound Rules For ALB Security Group"
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string) 
  }))
}

variable "alb_name" {
  description = "Name of teh ALB"
  type = string
}

variable "alb_is_internal" {
  description = "ALB Internal or External"
  type = bool
}

variable "enable_deletion_protection" {
  description = "If set to true, deletion protection is enabled"
  type = bool
}

variable "tg_name" {
  description = "Name of the Target Group"
  type = string
}

variable "tg_port" {
  description = "Target Group Port"
  type = number
}

variable "tg_protocol" {
  description = "Target Group Protocol"
  type = string
}

variable "tg_health_check_path" {
  description = "Target Group Health Check Path"
  type = string
}

variable "tg_health_check_matcher" {
  description = "HTTP Code to Consider Healthy"
  type = string
}

variable "alb_listener_port" {
  description = "ALB Listener Port"
  type = number
}

variable "alb_listener_protocol" {
  description = "ALB Listener Protocol"
  type = string
}

variable "alb_ssl_policy" {
  description = "AWS Security Policy For ALB"
  type = string
}

variable "ssl_arn" {
  description = "SSL Certificate ARN"
  type = string
}

variable "db_subnet_group" {
  description = "Name of the DB Subnet Group"
  type = string
}

variable "db_sg_name" {
  description = "Security Group FOR RDS"
  type = string
}

variable "db_sg_ingress_rules" {
  description = "Inbound Rules For DB Security Group"
  type = list(object({
    from_port = number
    to_port = number
    protocol = string

  }))
}

variable "db_sg_eggress_rules" {
  description = "Outbound Rules For DB Security Group"
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string) 
  }))
}

variable "db_identifier" {
  description = "DB Identifier"
  type = string
}

variable "db_name" {
  description = "Name of the DB"
  type = string
}

variable "db_instance_class" {
  description = "DB Instance Class"
  type = string
}
variable "db_storage" {
  description = "DB Storage"
  type = string
}

variable "db_username" {
  description = "Username For DB Instance"
  type = string
}

variable "db_password" {
  description = "Password For DB Instance"
  type = string
  sensitive = true
}

variable "github_token" {
  description = "GitHub Token"
  type = string
  sensitive = true
}