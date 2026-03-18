module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "qr-code-vpc"
  cidr = "10.0.0.0/16"

  # Two availability zones for high availability so if one goes down the other is still working
  azs             = ["us-east-2a", "us-east-2b"]

  # Public subnets for the load balancer which receives traffic from the internet
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  # Private subnets which is for the worker nodes and kept off the public internet for security
  # The NAT gateway allows the worker nodes to reach the internet without being exposed
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  # Allows private subnets to reach the internet without being publicly exposed
  enable_nat_gateway = true

  # One NAT gateway is enough but one per AZ would be HA but costly
  single_nat_gateway = true

  tags = {
    Environment = "dev"
    Project     = "qr-code"
  }
}