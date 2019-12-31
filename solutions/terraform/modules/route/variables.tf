variable "is_natgw" {
  description = "Is NAT gateway or not"
  type        = bool
  default     = false
}

variable "natgw_id" {
  type = string
}

variable "natgw_subnet_ids" {
  description = "NAT gateway subnet ID list"
  type        = list(string)
  default     = []
}

variable "natgw_route_table_id" {
  description = "NAT gateway route table ID"
  type        = string
}

variable "is_igw" {
  description = "Is internet gateway or not"
  type        = bool
  default     = false
}

variable "igw_id" {
  description = "Internet gateway ID"
  type         = string
}

variable "igw_subnet_ids" {
  description = "Internet gateway subnet ID list"
  type        = list(string)
  default     = []
}

variable "igw_route_table_id" {
  description = "Internet gateway route table ID"
  type = string
}
