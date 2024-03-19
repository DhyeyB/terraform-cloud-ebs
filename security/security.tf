# Security Group Setup

resource "aws_security_group" "server_security_group" {
  name        = var.security_group_name
  vpc_id      = var.vpc_id
  description = var.description
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      self            = lookup(ingress.value, "self", null)
      security_groups = lookup(ingress.value, "security_groups", null)
      cidr_blocks     = lookup(ingress.value, "cidr_blocks", null)
    }
  }

  dynamic "egress" {
    for_each = var.egress_rule != null && length(keys(var.egress_rule)) > 0 ? [1] : []
    content {
      from_port   = var.egress_rule.from_port
      to_port     = var.egress_rule.to_port
      protocol    = var.egress_rule.protocol
      cidr_blocks = var.egress_rule.cidr_blocks
    }
  }

  tags = {
    Name        = "${var.security_group_name}"
    Environment = "${var.environment}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
