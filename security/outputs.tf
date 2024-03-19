# Output Variables

output "security_group_id" {
  value       = aws_security_group.server_security_group.id
  description = "Security group id"
}
