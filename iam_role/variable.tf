variable "env" {
  description = "Please enter the environment in which resources are being deployed into"
  type        = string
}

variable "app_name" {
  description = "Name of deployed application"
  type        = string
}

variable "assume_role_policy_file_path" {
  description = "assume role policy file path"
  type = string
  nullable = false
}

variable "managed_policy_arn" {
  description = "managed policy arn"
  type = list
  default = null
}

variable "execution_policy_file_path" {
  description = "execution policy file path"
  type = string
  default = null
}