# Security Group for Public EC2 Instance
resource "aws_security_group" "public" {
  name        = "${var.project_name}-public-sg"
  description = "Security group for public EC2 instances"
  vpc_id      = var.vpc_id

  # Allow SSH from specified IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip]
    description = "SSH access from specified IP"
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${var.project_name}-public-sg"
  }
}

# Security Group for Private EC2 Instance
resource "aws_security_group" "private" {
  name        = "${var.project_name}-private-sg"
  description = "Security group for private EC2 instances"
  vpc_id      = var.vpc_id

  # Allow SSH from Public EC2 Security Group
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id]
    description     = "SSH access from public instances"
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${var.project_name}-private-sg"
  }
}