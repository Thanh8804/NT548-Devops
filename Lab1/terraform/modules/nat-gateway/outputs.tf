output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}

output "nat_eip" {
  value = aws_eip.nat.public_ip
}