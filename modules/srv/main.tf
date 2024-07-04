# CREATE AND DOWNLAOD SSH KEY PAIR 
resource "aws_key_pair" "task02-key" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa.public_key_openssh 
 }

resource "tls_private_key" "rsa" {
  algorithm = "RSA" 
  rsa_bits = 4096 
}

resource "local_file" "TF-key" {
  content = tls_private_key.rsa.private_key_pem
  filename = "${path.module}/../../task02-key"
}
# CREATE AN ELASTIC IP ADDRESS
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# CREATING A NAT GATEWAY
resource "aws_nat_gateway" "NAT_GATEWAY" {
  depends_on = [
    aws_eip.nat_eip
  ]
  allocation_id = aws_eip.nat_eip.id
  subnet_id = var.public_subnet_id
  tags = {
    Name = "Task02-Nat"
  }
}

# CREATE BASITION HOST
resource "aws_instance" "bastion" {
  ami           = var.srv_img
  instance_type = var.srv_type
  key_name      = var.key_name
  subnet_id     = var.public_subnet_id
  security_groups = [aws_security_group.bastion-sg.id] 
  depends_on = [aws_security_group.bastion-sg]
  associate_public_ip_address = true 
}

# CREATE PRIVATE INSTANCE 
resource "aws_instance" "private_instance" {
  ami           = var.srv_img
  instance_type = var.srv_type
  subnet_id     = var.private_subnet_id
  key_name      = var.key_name
  security_groups = [aws_security_group.private-sg.id]
  depends_on = [aws_security_group.private-sg]
 
}


# CREATE SECURITY GROUP FOR Private 
resource "aws_security_group" "private-sg" {
  name        = "private-sg" 
  vpc_id      = var.vpc_id 
  ingress {
    from_port   = 22 
    to_port     = 22
    protocol    = "tcp" 
    cidr_blocks = ["0.0.0.0/0"] 
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# CREATE SECURITY GROUP FOR BASION HOST 
resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg" 
  vpc_id      = var.vpc_id 
  ingress {
    from_port   = 22 
    to_port     = 22
    protocol    = "tcp" 
    cidr_blocks = ["0.0.0.0/0"] 
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# GENERTEA THE INVENTORY FILE FOR BASTION AND PRIVATE MACHINE

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "private_instance_private_ip" {
  value = aws_instance.private_instance.private_ip
}


resource "local_file" "inventory" {
  filename = "${path.module}/../../inventory"
  content = <<-EOT
Bastion machine 
${aws_instance.bastion.public_ip}
private_instance
${aws_instance.private_instance.private_ip}
EOT
}
