# ID OF THE VPC IN WHERE THE SUBNETS WILL BE IN 
variable "vpc_id"{
  type = string
}

# SSH KEY 
variable "key_name" {
  type = string 
}

# THE AMI ID FOR THE INSTANCES
variable "srv_img" {
  type = string
}
# THE INSTANCE TYPE FOR THE INSTANCES
variable "srv_type" {
  type = string
}

# # THE NAME OF THE EC2 KEY PAIR TO ASSOCIATE WITH THE INSTANCES
# variable "key_name" {
#   type  = string
# }


# PUBLIC SUBNET  ID 
variable "public_subnet_id" {
  type = string
}

# PRIVATE SUBNET  ID 
variable "private_subnet_id" {
  type = string
}




