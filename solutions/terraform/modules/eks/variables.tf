variable "name_prefix" {
  type    = string
  default = "default"
}

variable "security_groups" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
}
