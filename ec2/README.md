<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.server_elastic_ip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.ec2_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [null_resource.wait_for_user_data](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Application Name | `string` | n/a | yes |
| <a name="input_aws_public_subnet_id"></a> [aws\_public\_subnet\_id](#input\_aws\_public\_subnet\_id) | Public subnet id | `string` | n/a | yes |
| <a name="input_ec2_instance_type"></a> [ec2\_instance\_type](#input\_ec2\_instance\_type) | Instance type of EC2 | `string` | `"t3.large"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment Server Environment Name: prod/staging/dev | `string` | n/a | yes |
| <a name="input_instance_ami"></a> [instance\_ami](#input\_instance\_ami) | Instance ami | `string` | n/a | yes |
| <a name="input_instance_disk_size"></a> [instance\_disk\_size](#input\_instance\_disk\_size) | Instance Disk size in GB | `string` | `"20"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Instance Name | `string` | n/a | yes |
| <a name="input_server_security_group_id"></a> [server\_security\_group\_id](#input\_server\_security\_group\_id) | Server security group id | `string` | n/a | yes |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | The user data to provide when launching the instance. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_server_ip"></a> [ec2\_server\_ip](#output\_ec2\_server\_ip) | Elastic IP attached with EC2 server. |
<!-- END_TF_DOCS -->
