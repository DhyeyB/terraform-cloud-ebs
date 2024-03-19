# Output Variables
output "ec2_server_ip" {
  value       = aws_eip.server_elastic_ip.public_ip
  description = "Elastic IP attached with EC2 server."
}

output "ec2_instance_id" {
  value = aws_instance.ec2_server.id
  description = "Instance ID of the created EC2 server."
}

output "ec2_instance_az" {
  value = aws_instance.ec2_server.availability_zone
  description = "Availability Zone of created EC2 server."
}