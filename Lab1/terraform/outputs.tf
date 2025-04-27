output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "public_instance_ip" {
  value = module.ec2.public_instance_ip
}

output "private_instance_ip" {
  value = module.ec2.private_instance_ip
}

output "public_security_group_id" {
  value = module.security_groups.public_sg_id
}

output "private_security_group_id" {
  value = module.security_groups.private_sg_id
}