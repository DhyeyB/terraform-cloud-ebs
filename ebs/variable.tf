variable "ebs_instance_disk_size" {
  description = "Instance EBS Disk size in GB"
  type        = string
  nullable    = false
  default     = ""
}

variable "ec2_instance_id" {
  description = "EC2 Instance ID"
  type        = string
  nullable    = false
  default     = ""
}

variable "ec2_az" {
  description = "EC2 Availability Zone"
  type        = string
  nullable    = false
  default     = ""
}

variable "ebs_type" {
  description = "ebS volume type"
  type        = string
  nullable    = false
  default     = "gp2"
}

variable "ebs_snapshot" {
  description = "If EBS volume snapshot is required then it's value should be yes otherwise it's value should no"
  type        = string
}

variable "retention_period" {
  description = "Define retention period of ebs volume"
  type = number
}

variable "execution_role_arn" {
  description = "ARN of the execution role for the dlm lifecycle role of the ebs volume snapshot"
  type = string
}