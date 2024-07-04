# CREATE PUBLIC SUBNET 
resource "aws_subnet" "public_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.pub_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = var.pub_subnet_name
  }
}

# CREATE PUBLIC ROUTE TABLE 
resource "aws_route_table" "public_rt" { 
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
  tags = {
    Name = "public_rt"
  }
}

# ASSIGN THE PUBLIC ROUTE TABLE TO THE PUBLIC SUBNET
resource "aws_route_table_association" "pub_rta" { 
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# CREATE PRIVATE SUBNET 
resource "aws_subnet" "private_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = false  

  tags = {
    Name = var.private_subnet_name
  }
}

# CREATE ROUTE TABLE  PRIVATE subnet 
resource "aws_route_table" "pri_rt" {
  vpc_id = var.vpc_id 
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }
  tags = {
    Name = "Route Table for NAT Gateway"
  }
}

# ASSOCIATED PRIVATE ROUTE TABLE TO PRIVATE SUBNET 
resource "aws_route_table_association" "pri_rta" {
  depends_on = [
    aws_route_table.pri_rt
  ]
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.pri_rt.id 
}