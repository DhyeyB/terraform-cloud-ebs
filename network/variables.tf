# Terraform Variables


variable "app_name" {
  description = "Application Name"
  type        = string
  nullable    = false
}

variable "environment" {
  description = "Deployment Server Environment Name: prod/staging/dev"
  type        = string
  nullable    = false
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  type        = string
  nullable    = false
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC  cidr blocks"
  nullable    = false
  default     = "172.17.0.0/16"
}

variable "public_route_destination_cidr_block" {
  type        = string
  description = "AWS public route destination cidr blocks"
  nullable    = false
  default     = "0.0.0.0/0"
}

variable "private_route_destination_cidr_block" {
  type        = string
  description = "AWS private route destination cidr blocks"
  nullable    = false
  default     = "0.0.0.0/0"
}
