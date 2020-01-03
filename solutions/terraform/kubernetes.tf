module "eks_sg" {
  source = "./modules/security-group"

  name   = "app-com-eks-sg-${terraform.workspace}"
  vpc_id = module.vpc.id

  rules = [
    {
      type                     = "ingress"
      from_port                = 443
      to_port                  = 443
      protocol                 = "tcp"
      cidr_blocks              = var.workstation_ip
      self                     = null
      source_security_group_id = null
      description              = "Ingress from workstation to EKS cluster"
    }
  ]

  tags = {
    Environment = terraform.workspace
  }
}

module "eks" {
  source = "./modules/eks"

  name_prefix     = "app-com-${terraform.workspace}"
  security_groups = [module.alb_sg.id]
  subnet_ids      = module.priv_subnet.subnet_ids

  tags = {
    Environment = terraform.workspace
  }
}
