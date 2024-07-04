output "nat_gateway_id" {
  value = aws_nat_gateway.NAT_GATEWAY.id 
}


# output "bastion_ip" {
#   value = aws_instance.bastion.public_ip
# }

# output "private_instance_ip" {
#   value = aws_instance.private_instance.private_ip
# }
