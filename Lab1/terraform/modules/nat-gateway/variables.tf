variable "public_subnet_ids" {
  description = "IDs of public subnets where NAT Gateway will be placed"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "project_name" {
  description = "Name of the project for resource tagging"
  type        = string
}