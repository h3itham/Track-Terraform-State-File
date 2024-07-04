# ADDED VPC MODULE FOR NETWORK SETUP
module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  vpc_name            = var.vpc_name   
}

# IMPLEMENTED SUBNET MODULE FOR MANAGING SUBNETS WITHIN VPC
module "subnet" {
  source              = "./modules/subnets"
  vpc_id              = module.vpc.vpc_id
  igw_id              = module.vpc.igw_id
  nat_gateway_id      = module.srv.nat_gateway_id
  availability_zone   = var.availability_zone
  pub_cidr            = var.pub_cidr
  pub_subnet_name     = var.pub_subnet_name 
  private_cidr        = var.private_cidr 
  private_subnet_name = var.private_cidr
}

# SERVERS MODULS BASTION AND PRIVATE INSTANCE
module "srv" {
  source             = "./modules/srv"
  vpc_id             = module.vpc.vpc_id
  public_subnet_id   = module.subnet.public_subnet_id
  private_subnet_id  = module.subnet.private_subnet_id
  srv_img            = var.srv_img
  srv_type           = var.srv_type
  key_name           = var.key_name
}
