variable "cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "name" {
  description = "VPC name"
  type        = string
}

variable "tags" {
  description = "VPC tags"
  type        = map(string)
}
