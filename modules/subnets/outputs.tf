# OUTPUT OF PUBLIC SUBNET  ID 
output "public_subnet_id" {
    value = aws_subnet.public_subnet.id 
}

# OUTPUT OF PRIVATE SUBNET ID 
output "private_subnet_id" {
    value = aws_subnet.private_subnet.id
}
