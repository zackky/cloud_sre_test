module "vpc" {
  source = "./modules/vpc"

  cidr_block = var.vpc_cidr_block[terraform.workspace]
  name       = "app-com-vpc-${terraform.workspace}"

  tags = {
    Environment = terraform.workspace
  }
}

module "gw" {
  source = "./modules/gateway"

  igw_name          = "app-com-igw-${terraform.workspace}"
  natgw_name        = "app-com-natgw-${terraform.workspace}"
  natgw_subnet_cidr = var.natgw_subnet_cidr[terraform.workspace]
  vpc_id            = module.vpc.id

  tags = {
    Environment = terraform.workspace
  }
}

module "pub_subnet" {
  source = "./modules/subnet"

  name_prefix = "app-com-pub-subnet-${terraform.workspace}"
  cidr_blocks = var.pub_subnet_cidr_blocks[terraform.workspace]
  azs         = data.aws_availability_zones.az.names
  vpc_id      = module.vpc.id
  is_public   = true

  tags = {
    Environment = terraform.workspace
  }
}

module "priv_subnet" {
  source = "./modules/subnet"

  name_prefix = "app-com-priv-subnet-${terraform.workspace}"
  cidr_blocks = var.priv_subnet_cidr_blocks[terraform.workspace]
  azs         = data.aws_availability_zones.az.names
  vpc_id      = module.vpc.id
  is_public   = false

  tags = {
    Environment = terraform.workspace
  }
}

module "routing" {
  source = "./modules/route"

  is_igw             = true
  igw_id             = module.gw.igw_id
  igw_route_table_id = module.gw.route_table_public
  igw_subnet_ids     = module.pub_subnet.subnet_ids

  is_natgw             = true
  natgw_id             = module.gw.natgw_id
  natgw_route_table_id = module.gw.route_table_private
  natgw_subnet_ids     = module.priv_subnet.subnet_ids
}

module "alb_sg" {
  source = "./modules/security-group"

  name   = "app-com-alb-sg-${terraform.workspace}"
  vpc_id = module.vpc.id

  rules = [
    {
      type                     = "ingress"
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      cidr_blocks              = ["0.0.0.0/0"]
      self                     = null
      source_security_group_id = null
      description              = "Public ingress for ALB"
    },
    {
      type                     = "egress"
      from_port                = 0
      to_port                  = 0
      protocol                 = "-1"
      cidr_blocks              = ["0.0.0.0/0"]
      self                     = null
      source_security_group_id = null
      description              = "Public egress for ALB"
    }
  ]

  tags = {
    Environment = terraform.workspace
  }
}

module "alb" {
  source = "./modules/alb"

  name_prefix = "app-com-${terraform.workspace}"

  vpc_id          = module.vpc.id
  security_groups = [module.alb_sg.id]
  subnets         = module.pub_subnet.subnet_ids

  is_stickiness = true

  tags = {
    Environment = terraform.workspace
  }
}
