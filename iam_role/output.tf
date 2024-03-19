output "role_arn" {
  value       = aws_iam_role.execution_role.arn
  description = "Execution role arn"
}