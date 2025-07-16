# Lab1-Devops
# Terraform AWS VPC Infrastructure

This project deploys a complete AWS infrastructure using Terraform, including VPC, subnets, Internet Gateway, NAT Gateway, Route Tables, EC2 instances, and Security Groups.

## Infrastructure Components

- **VPC**: A custom VPC with CIDR 10.0.0.0/16
- **Subnets**: 
  - Public subnets with direct access to the internet via Internet Gateway
  - Private subnets accessing the internet via NAT Gateway
- **Internet Gateway**: Allows resources in public subnets to connect to the internet
- **NAT Gateway**: Allows resources in private subnets to connect to the internet while remaining private
- **Route Tables**: 
  - Public route table directing traffic to the Internet Gateway
  - Private route table directing traffic to the NAT Gateway
- **EC2 Instances**:
  - Public instance accessible from a specified IP address
  - Private instance only accessible from the public instance
- **Security Groups**:
  - Public security group allowing SSH from a specified IP
  - Private security group allowing SSH only from the public instance

## Prerequisites

- AWS account
- AWS CLI configured with appropriate credentials
- Terraform installed
- SSH key pair created in AWS

## How to Deploy

1. Clone this repository:
   ```
   git clone <repository-url>
   cd terraform-aws-vpc
   ```

2. Update the `terraform.tfvars` file with your specific values:
   ```
   region       = "us-east-1"
   vpc_cidr     = "10.0.0.0/16"
   project_name = "terraform-vpc-project"
   allowed_ip   = "YOUR_IP_ADDRESS/32"  # Replace with your IP address
   key_name     = "your-key-pair"       # Replace with your AWS key pair name
   instance_type = "t2.micro"
   ```

3. Initialize Terraform:
   ```
   terraform init
   ```

4. Create an execution plan:
   ```
   terraform plan
   ```

5. Apply the Terraform configuration:
   ```
   terraform apply
   ```

6. Confirm by typing `yes` when prompted.

## Testing the Infrastructure

### Connecting to the Public Instance

```bash
ssh -i /path/to/your-key-pair.pem ec2-user@$(terraform output -raw public_instance_ip)
```

### Connecting to the Private Instance (from the Public Instance)

First, copy your key to the public instance:
```bash
scp -i /path/to/your-key-pair.pem /path/to/your-key-pair.pem ec2-user@$(terraform output -raw public_instance_ip):~/.ssh/
```

Then, SSH to the public instance:
```bash
ssh -i /path/to/your-key-pair.pem ec2-user@$(terraform output -raw public_instance_ip)
```

From the public instance, connect to the private instance:
```bash
ssh -i ~/.ssh/your-key-pair.pem ec2-user@$(terraform output -raw private_instance_ip)
```

Test internet connectivity on the private instance:
```bash
ping google.com
```

## Cleanup

To destroy all resources created:
```
terraform destroy
```

Confirm by typing `yes` when prompted.