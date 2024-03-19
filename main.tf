terraform {
  cloud {
    organization = "Terraform-Practice-AWS"

    workspaces {
      name = "test-ec2"
    }
  }
}

provider "aws" {
  region     = var.aws_region
}

module "iam_role" {
  source                       = "./iam_role"
  app_name                     = var.app_name
  env                          = var.environment
  assume_role_policy_file_path = var.assume_role_policy_file_path
  execution_policy_file_path   = var.execution_policy_file_path
}

/* Security Group for resources that want to access the EC2 */
module "server_security_group" {
  source              = "./security"
  security_group_name = "${var.instance_name}-${var.environment}"
  description         = "Security Group for EC2"
  environment         = var.environment
  ingress_rules = [for port in var.ingress_ports : {
    from_port   = port
    to_port     = port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }]
  egress_rule = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "ec2" {
  source                   = "./ec2"
  app_name                 = var.app_name
  environment              = var.environment
  instance_name            = var.instance_name
  instance_ami             = var.instance_ami
  ec2_instance_type        = var.ec2_instance_type
  rsa_key_1                = var.rsa_key_1
  db_name                  = var.db_name
  db_user                  = var.db_user
  db_password              = var.db_password
  format_db_volume         = var.format_db_volume
  server_security_group_id = module.server_security_group.security_group_id
}

module "ebs" {
  source                 = "./ebs"
  ebs_instance_disk_size = var.ebs_instance_disk_size
  ebs_type               = var.ebs_type
  ec2_az                 = module.ec2.ec2_instance_az
  ec2_instance_id        = module.ec2.ec2_instance_id
  ebs_snapshot           = var.ebs_snapshot
  execution_role_arn     = module.iam_role.role_arn
  retention_period       = var.retention_period
}
