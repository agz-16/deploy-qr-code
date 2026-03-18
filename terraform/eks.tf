module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  # Name and Kubernetes version
  cluster_name    = "qr-code-cluster"
  cluster_version = "1.31"

  # Make the cluster API accessible from your laptop
  # without this i'd the cluster API would only be accessible from inside the VPC 
  # this allows me to access it from my laptop so no VPN or bastion host needed
  cluster_endpoint_public_access = true

  # Gives admin access to the cluster
  enable_cluster_creator_admin_permissions = true

  # Use the VPC and private subnets created in vpc.tf
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Worker nodes aka the EC2 instances that run the containers
  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.small"]
      # Minimum 1 node so the cluster is always running
      min_size       = 1
      # Maximum 2 nodes — allows scaling up if needed
      max_size       = 2
      # Start with 1 node to keep costs low
      desired_size   = 1
    }
  }

  tags = {
    Environment = "dev"
    Project     = "qr-code"
  }
}