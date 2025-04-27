variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "allowed_ip" {
  description = "IP address allowed to SSH into the public EC2 instance"
  type        = string
}

variable "project_name" {
  description = "Name of the project for resource tagging"
  type        = string
}