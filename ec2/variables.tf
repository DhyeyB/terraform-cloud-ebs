# Terraform Variables

variable "app_name" {
  type        = string
  description = "Application Name"
  nullable    = false
}

variable "environment" {
  type        = string
  description = "Deployment Server Environment Name: prod/staging/dev"
  nullable    = false
}

variable "instance_name" {
  description = "Instance Name"
  type        = string
  nullable    = false
}

variable "instance_ami" {
  description = "Instance ami"
  type        = string
  nullable    = false

}

variable "ec2_instance_type" {
  description = "Instance type of EC2"
  type        = string
  nullable    = false
  default     = "t3.large"

}

variable "instance_disk_size" {
  description = "Instance Disk size in GB"
  type        = string
  nullable    = false
  default     = "20"

}

variable "server_security_group_id" {
  description = "Server security group id"
  type        = string
  nullable    = false
}

variable "aws_public_subnet_id" {
  description = "Public subnet id"
  type        = string
  default = ""
}


variable "rsa_key_1" {
  description = "Public rsa key 1st"
  type        = string
  nullable    = false
  default     = ""
}

variable "db_user" {
  description = "Postgres database username"
  type        = string
  nullable    = false
}

variable "db_name" {
  description = "Database name"
  type        = string
  nullable    = false
}

variable "db_password" {
  description = "Password to access database."
  type        = string
  nullable    = false
}

variable "format_db_volume" {
  description = "formate db volume flag"
  type        = string
}