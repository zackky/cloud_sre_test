variable "igw_name" {
  description = "Internet gateway name"
  type        = string
}

variable "natgw_name" {
  description = "NAT gateway name"
  type        = string
}

variable "natgw_subnet_cidr" {
  description = "NAT gateway subnet CIDR"
  type        = string
}

variable "vpc_id" {
  description = "Gateway VPC ID"
  type        = string
}

variable "tags" {
  description = "Gateway tags"
  type        = map(string)
}
