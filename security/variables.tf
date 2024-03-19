# Terraform Variables

variable "environment" {
  description = "Deployment Server Environment Name: prod/staging/dev"
  nullable    = false
  type        = string
}

variable "security_group_name" {
  description = "Securtiy Group Name"
  type        = string
  nullable    = false
}

variable "vpc_id" {
  type        = string
  description = "Network VPC ID"
  default = ""
}


variable "description" {
  type        = string
  description = "Security Group Description"
  default     = ""
}


variable "ingress_rules" {
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    self            = optional(bool)
    security_groups = optional(list(string))
    cidr_blocks     = optional(list(string))
    // Add any other ingress rule attributes here
  }))
  description = "The list of ingress rules for the security group"
}

variable "egress_rule" {
  type = object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  })
  description = "The egress rule for the security group"
}
