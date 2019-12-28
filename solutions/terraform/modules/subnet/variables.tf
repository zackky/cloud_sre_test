variable "name_prefix" {
  description = "Subnet name prefix"
  type        = string
  default     = "subnet"
}

variable "cidr_blocks" {
  description = "Subnet CIDR block list"
  type        = list(string)
}

variable "is_public" {
  description = "Subnet should be assigned a public IP or not"
  type        = bool
  default     = false
}

variable "azs" {
  description = "Subnet AZ list"
  type        = list(string)
}

variable "vpc_id" {
  description = "Subnet VPC ID"
  type        = string
}

variable "tags" {
  description = "Subnet tags"
  type        = map(string)
}
