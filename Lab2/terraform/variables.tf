variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "project_name" {
  description = "Name of the project for resource tagging"
  type        = string
  default     = "terraform-vpc-project"
}

variable "allowed_ip" {
  description = "IP address allowed to SSH into the public EC2 instance"
  type        = string
  default     = "0.0.0.0/0"  # Should be restricted to your IP in production
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}