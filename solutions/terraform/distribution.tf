module "cdn" {
  source = "./modules/cdn"

  providers = {
    aws = aws.us
  }

  name_prefix      = "app-com-${terraform.workspace}"
  root_domain_name = var.domain_name
  domain_name      = var.domain_name
  origins = [
    {
      domain_name            = module.s3_www.bucket_regional_domain_name
      origin_id              = module.s3_www.bucket_regional_domain_name
      origin_protocol_policy = "http-only"
    },
    {
      domain_name            = module.alb.dns_name
      origin_id              = module.alb.dns_name
      origin_protocol_policy = "http-only"
    }
  ]
  s3www_domain_name = module.s3_www.bucket_regional_domain_name
  ordered_cache_behaviors = [
    {
      path_pattern           = "/api"
      viewer_protocol_policy = "allow-all"
      cache_compress         = true
      allowed_methods        = ["GET", "HEAD"]
      cached_methods         = ["GET", "HEAD"]
      target_origin_id       = module.alb.dns_name
      min_ttl                = 0
      default_ttl            = 0
      max_ttl                = 0
      forward_query_string   = true
      forward_cookies        = "none"
    },
    {
      path_pattern           = "/api/*"
      viewer_protocol_policy = "allow-all"
      cache_compress         = true
      allowed_methods        = ["GET", "HEAD"]
      cached_methods         = ["GET", "HEAD"]
      target_origin_id       = module.alb.dns_name
      min_ttl                = 0
      default_ttl            = 0
      max_ttl                = 0
      forward_query_string   = true
      forward_cookies        = "none"
    }
  ]

  tags = {
    Environment = terraform.workspace
  }
}

module "dns" {
  source = "./modules/dns"

  name_prefix      = "app-com-${terraform.workspace}"
  root_domain_name = var.domain_name
  ttl              = "30"

  dns_records = [
    {
      name = "*"
      type = "CNAME"
      records = [
        module.cdn.cdn_domain_name
      ]
    },
    {
      name    = module.cdn.cert_domain_validation.0.resource_record_name
      type    = module.cdn.cert_domain_validation.0.resource_record_type
      records = [module.cdn.cert_domain_validation.0.resource_record_value]
    }
  ]

  tags = {
    Environment = terraform.workspace
  }
}
