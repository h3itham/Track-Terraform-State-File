# PROVIDERS VALUES 
profile  = "default"
region   = "ap-northeast-1"

# VPC MODULE VALUES
vpc_cidr = "10.0.0.0/16"
vpc_name = "Task02-prod-vpc"
# SSH KEY NAME
key_name        = "Task2-key"
# SUBNET MODULE VALUES 
availability_zone = "ap-northeast-1a"
pub_cidr          = "10.0.1.0/24"
pub_subnet_name   = "public-subnet"
private_cidr      = "10.0.2.0/24"
private_subnet_name = "private-subnet"

# SRV MODULE VALUES 
srv_img          = "ami-01bef798938b7644d"
srv_type         = "t2.micro"

# NOITFICATION MODULE VALUES 

sender_email    = "haithamelabd@outlook.com"
recipient_email = "haithamelabd@outlook.com"
