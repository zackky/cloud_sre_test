variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "region" {
  description = "S3 region"
  type        = string
}

variable "index_document" {
  description = "Website default home page"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "Website default error page"
  type        = string
  default     = "error.html"
}

variable "tags" {
  description = "S3 tags"
  type        = map(string)
}
