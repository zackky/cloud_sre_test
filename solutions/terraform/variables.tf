# ====
# Main
# ====
variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "aws_profile" {
  type    = string
  default = ""
}

# ====
# Common
# ====
variable "domain_name" {
  type     = string
  default  = "app.com"
}

# ====
# Network
# ====
variable "vpc_cidr_block" {
  type    = map(string)
  default = {
    dev     = "10.3.0.0/16"
    stag    = "10.2.0.0/16"
    prod    = "10.1.0.0/16"
    default = "10.0.0.0/16"
  }
}

variable "natgw_subnet_cidr" {
  type    = map(string)
  default = {
    dev     = "10.3.255.0/28"
    stag    = "10.2.255.0/28"
    prod    = "10.1.255.0/28"
    default = "10.0.255.0/28"
  }
}

variable "pub_subnet_cidr_blocks" {
  type    = map(list(string))
  default = {
    dev     = ["10.3.1.0/28", "10.3.1.16/28", "10.3.1.32/28"]
    stag    = ["10.2.1.0/28", "10.2.1.16/28", "10.2.1.32/28"]
    prod    = ["10.1.1.0/28", "10.1.1.16/28", "10.1.1.32/28"]
    default = ["10.0.1.0/28", "10.0.1.16/28", "10.0.1.32/28"]
  }
}

variable "priv_subnet_cidr_blocks" {
  type    = map(list(string))
  default = {
    dev     = ["10.3.2.0/24", "10.3.3.0/24", "10.3.4.0/24"]
    stag    = ["10.2.2.0/24", "10.2.3.0/24", "10.2.4.0/24"]
    prod    = ["10.1.2.0/24", "10.1.3.0/24", "10.1.4.0/24"]
    default = ["10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
  }
}

# ====
# Data
# ====
variable "priv_redis_subnet_cidr_blocks" {
  type    = map(list(string))
  default = {
    dev     = ["10.3.5.0/24", "10.3.6.0/24", "10.3.7.0/24"]
    stag    = ["10.2.5.0/24", "10.2.6.0/24", "10.2.7.0/24"]
    prod    = ["10.1.5.0/24", "10.1.6.0/24", "10.1.7.0/24"]
    default = ["10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24"]
  }
}

variable "priv_aurora_subnet_cidr_blocks" {
  type    = map(list(string))
  default = {
    dev     = ["10.3.8.0/24", "10.3.9.0/24", "10.3.10.0/24"]
    stag    = ["10.2.8.0/24", "10.2.9.0/24", "10.2.10.0/24"]
    prod    = ["10.1.8.0/24", "10.1.9.0/24", "10.1.10.0/24"]
    default = ["10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24"]
  }
}

variable "aurora_db_name" {
  type = string
}

variable "aurora_db_master_username" {
  type = string
}

variable "aurora_db_master_password" {
  type = string
}

# ====
# Kubernetes
# ====
variable "workstation_ip" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
