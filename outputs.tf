# Output Variables

output "app_env" {
  value       = var.environment
  description = "App environment"
}

output "ec2_server_ip" {
  value       = module.ec2.ec2_server_ip
  description = "Elastic IP attached with EC2 server."
}

output "ec2_instance_id" {
  value = module.ec2.ec2_instance_id
}