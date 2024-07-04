# CREATE A VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags       = {
    Name     = var.vpc_name  
  }
}
# CREATE AN INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
  vpc_id  = aws_vpc.vpc.id
  tags    = {
    Name  = "Task02-IGW"
  }
}
