terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.84.0"
    }
  }

  required_version = ">= 1.2.0"
}


module "vpc" {
  source            = "./modules/vpc"
  vpc_cidr          = var.vpc_cidr
  project_name      = var.project_name
}

module "security_groups" {
  source         = "./modules/security-groups"
  vpc_id         = module.vpc.vpc_id
  allowed_ip     = var.allowed_ip
  project_name   = var.project_name
}

module "nat_gateway" {
  source            = "./modules/nat-gateway"
  public_subnet_ids = module.vpc.public_subnet_ids
  vpc_id            = module.vpc.vpc_id
  project_name      = var.project_name
}

module "route_tables" {
  source            = "./modules/route-tables"
  vpc_id            = module.vpc.vpc_id
  igw_id            = module.vpc.igw_id
  nat_gateway_id    = module.nat_gateway.nat_gateway_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  project_name      = var.project_name
}

module "ec2" {
  source                  = "./modules/ec2"
  vpc_id                  = module.vpc.vpc_id
  public_subnet_ids       = module.vpc.public_subnet_ids
  private_subnet_ids      = module.vpc.private_subnet_ids
  public_security_group_id = module.security_groups.public_sg_id
  private_security_group_id = module.security_groups.private_sg_id
  key_name                = var.key_name
  instance_type           = var.instance_type
  project_name            = var.project_name
}
