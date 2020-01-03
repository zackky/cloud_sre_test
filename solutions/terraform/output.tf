# ====
# Network
# ====
output "vpc_id" {
  value = module.vpc.id
}

output "igw_id" {
  value = module.gw.igw_id
}

output "pub_subnet_ids" {
  value = module.pub_subnet.subnet_ids
}

output "priv_subnet_ids" {
  value = module.priv_subnet.subnet_ids
}

output "public_route_id" {
  value = module.gw.route_table_public
}

output "private_route_id" {
  value = module.gw.route_table_private
}

output "alb_sg_id" {
  value = module.alb_sg.id
}

output "alb_id" {
  value = module.alb.id
}

output "alb_dns_name" {
  value = module.alb.dns_name
}

output "alb_target_group_arn" {
  value = module.alb.target_group_arn
}

# ====
# Data
# ====
output "s3_www_id" {
  value = module.s3_www.id
}

output "s3_www_bucket_domain_name" {
  value = module.s3_www.bucket_domain_name
}

output "s3_www_arn" {
  value = module.s3_www.arn
}

output "s3_www_bucket_regional_domain_name" {
  value = module.s3_www.bucket_regional_domain_name
}

output "s3_www_website_endpoint" {
  value = module.s3_www.website_endpoint
}

output "s3_www_website_domain" {
  value = module.s3_www.website_domain
}

# ====
# Kubernetes
# ====
output "kubernetes_endpoint" {
  value = module.eks.endpoint
}
