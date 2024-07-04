# ID OF THE VPC IN WHERE THE SUBNETS WILL BE
variable "vpc_id"{
  type = string
}

# INTERNET GATE WAY ID 
variable "igw_id" {
  type = string
}

# NAT GATWAY ID 
variable "nat_gateway_id" {
  type = string 
}

# MAIN AVAILABILITY ZONE 
variable "availability_zone" {
  type = string   
}

# PUBLIC SUBNET INFO
variable "pub_cidr" {
  type = string   
}
variable "pub_subnet_name" {
  type = string   
}

# PRIVATE SUBNET INFO
variable "private_cidr"{
  type = string 
}
variable "private_subnet_name" {
 type  = string  
}