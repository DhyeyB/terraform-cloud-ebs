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

variable "aws_region" {
  type        = string
  description = "Aws Region for resource creation"
  nullable    = false
}

variable "instance_name" {
  description = "Instance Name"
  type        = string
  nullable    = false
  default     = ""
}

variable "ingress_ports" {
  description = "Inbound ports to be opened."
  type        = list(number)
  nullable    = false
}

variable "instance_ami" {
  description = "Instance ami"
  type        = string
  nullable    = false
}

variable "ec2_instance_type" {
  description = "Instance type"
  type        = string
  nullable    = false
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

variable "ebs_instance_disk_size" {
  description = "Instance EBS Disk size in GB"
  type        = string
  nullable    = false
  default     = ""
}

variable "format_db_volume" {
  description = "formate db volume flag"
  type        = string
}

variable "ebs_type" {
  description = "ebS volume type"
  type        = string
  nullable    = false
}

variable "assume_role_policy_file_path" {
  description = "assume role policy file path"
  type        = string
  nullable    = false
}

variable "execution_policy_file_path" {
  description = "execution policy file path"
  type        = string
  default     = null
}

variable "ebs_snapshot" {
  description = "If EBS volume snapshot is required then it's value should be yes otherwise it's value should no"
  type        = string
}

variable "retention_period" {
  description = "Define retention period of ebs volume"
  type        = number
}