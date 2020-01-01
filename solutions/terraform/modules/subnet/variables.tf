variable "name_prefix" {
  type = string
  default = "subnet"
}

variable "cidr_blocks" {
  type = list(string)
}

variable "is_public" {
  type    = bool
  default = false
}

variable "azs" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "tags" {
  type = map(string)
}
