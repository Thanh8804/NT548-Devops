# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-nat-eip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_ids[0]  # Place NAT Gateway in the first public subnet

  tags = {
    Name = "${var.project_name}-nat-gateway"
  }

  # To ensure proper ordering, add a dependency on the Internet Gateway
  depends_on = [aws_eip.nat]
}