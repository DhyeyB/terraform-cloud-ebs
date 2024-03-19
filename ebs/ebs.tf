# EBS volume for Database
resource "aws_ebs_volume" "db_volume" {
  availability_zone = var.ec2_az# Change to your desired availability zone
  size              = var.ebs_instance_disk_size            # Change to your desired size in GiB
  type              = var.ebs_type         # Change volume type if needed
  lifecycle {
    ignore_changes = [ availability_zone ]
  }

  tags = {
    "name" = "dhyey-volume"
  }
}

resource "aws_volume_attachment" "db_ebs_attachment" {
  device_name = "/dev/xvdb"  # Change to your desired device name (e.g., /dev/sdf, /dev/xvdf)
  volume_id   = aws_ebs_volume.db_volume.id
  instance_id = var.ec2_instance_id
  force_detach = true  # This allows Terraform to detach the volume even if it's currently attached to an instance
  # lifecycle {
  #   ignore_changes = [ volume_id,  instance_id]
  # }
}

resource "aws_dlm_lifecycle_policy" "example_policy" {
  count = var.ebs_snapshot == "yes" ? 1 : 0

  description = "Snapshot retention policy"
  
  execution_role_arn = var.execution_role_arn

  policy_details {
    resource_types = ["VOLUME"]

    schedule {
      name = "Daily snapshot of EBS"

      create_rule {
        interval        = 1
        interval_unit   = "HOURS"
        times           = ["12:51"]
      }

      retain_rule {
        count = var.retention_period
      }
    }
    target_tags = aws_ebs_volume.db_volume.tags
  }
}