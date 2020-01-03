module "priv_redis_subnet" {
  source = "./modules/subnet"

  name_prefix = "app-com-priv-redis-subnet-${terraform.workspace}"
  cidr_blocks = var.priv_redis_subnet_cidr_blocks[terraform.workspace]
  azs         = data.aws_availability_zones.az.names
  vpc_id      = module.vpc.id
  is_public   = false

  tags = {
    Environment = terraform.workspace
  }
}

module "priv_aurora_subnet" {
  source = "./modules/subnet"

  name_prefix = "app-com-priv-aurora-subnet-${terraform.workspace}"
  cidr_blocks = var.priv_aurora_subnet_cidr_blocks[terraform.workspace]
  azs         = data.aws_availability_zones.az.names
  vpc_id      = module.vpc.id
  is_public   = false

  tags = {
    Environment = terraform.workspace
  }
}

locals {
  data_subnet_ids = concat(module.priv_redis_subnet.subnet_ids, module.priv_aurora_subnet.subnet_ids)
}


resource "aws_route_table_association" "data" {
  count = length(local.data_subnet_ids)

  subnet_id      = local.data_subnet_ids[count.index]
  route_table_id = module.gw.route_table_private
}

module "redis_sg" {
  source = "./modules/security-group"

  name   = "app-com-redis-sg-${terraform.workspace}"
  vpc_id = module.vpc.id

  rules = [
    {
      type                     = "ingress"
      from_port                = 6379
      to_port                  = 6379
      protocol                 = "tcp"
      cidr_blocks              = null
      self                     = null
      source_security_group_id = module.eks_sg.id
      description              = "Ingress for Redis"
    },
    {
      type                     = "egress"
      from_port                = 0
      to_port                  = 0
      protocol                 = "-1"
      cidr_blocks              = ["0.0.0.0/0"]
      self                     = null
      source_security_group_id = null
      description              = "Public egress for Redis"
    }
  ]

  tags = {
    Environment = terraform.workspace
  }
}

module "aurora_sg" {
  source = "./modules/security-group"

  name   = "app-com-aurora-sg-${terraform.workspace}"
  vpc_id = module.vpc.id

  rules = [
    {
      type                     = "ingress"
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "tcp"
      cidr_blocks              = null
      self                     = null
      source_security_group_id = module.eks_sg.id
      description              = "Ingress for Aurora"
    },
    {
      type                     = "egress"
      from_port                = 0
      to_port                  = 0
      protocol                 = "-1"
      cidr_blocks              = ["0.0.0.0/0"]
      self                     = null
      source_security_group_id = null
      description              = "Public egress for Aurora"
    }
  ]

  tags = {
    Environment = terraform.workspace
  }
}

module "redis_cluster" {
  source = "./modules/elasticache"

  name_prefix = "app-com-${terraform.workspace}"

  subnet_ids         = module.priv_redis_subnet.subnet_ids
  availability_zones = data.aws_availability_zones.az.names
  security_group_ids = [module.redis_sg.id]

  tags = {
    Environment = terraform.workspace
  }
}

module "aurora_cluster" {
  source = "./modules/aurora"

  name_prefix = "app-com-${terraform.workspace}"

  subnet_ids         = module.priv_aurora_subnet.subnet_ids
  availability_zones = data.aws_availability_zones.az.names
  security_group_ids = [module.aurora_sg.id]

  db_name            = var.aurora_db_name
  db_master_username = var.aurora_db_master_username
  db_master_password = var.aurora_db_master_password

  tags = {
    Environment = terraform.workspace
  }
}

module "s3_www" {
  source = "./modules/s3-www"

  bucket_name = replace("${var.domain_name}", ".", "-")
  region      = var.aws_region

  tags = {
    Environment = terraform.workspace
  }
}
