# PROVIDERS VARIABLES 
variable "profile" {}
variable "region" {}

# VPC MODULE  VARIABLES
variable "vpc_cidr"{}
variable "vpc_name" {
  type = string 
}

# SSH KEY NAME 
variable "key_name" {
  type = string 
}


# SUBNET MODULE VARIABLES

variable "availability_zone" {
  type = string   
}

variable "pub_cidr" {
  type = string   
}
variable "pub_subnet_name" {
  type = string   
}

variable "private_cidr"{
  type = string 
}

variable "private_subnet_name" {
 type  = string  
}

# SRV MODULE VARIABLES
variable "srv_img" {
  type = string
}

variable "srv_type" {
  type = string 
}

# NOTIFICATION MODULE VARIABLES 

variable "sender_email" {
  type        = string
}

variable "recipient_email" {
  type        = string
}
