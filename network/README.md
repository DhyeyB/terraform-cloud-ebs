<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_subnet_group.rds_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_eip.gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.ngw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.app-vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Application Name | `string` | n/a | yes |
| <a name="input_az_count"></a> [az\_count](#input\_az\_count) | Number of AZs to cover in a given region | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment Server Environment Name: prod/staging/dev | `string` | n/a | yes |
| <a name="input_private_route_destination_cidr_block"></a> [private\_route\_destination\_cidr\_block](#input\_private\_route\_destination\_cidr\_block) | AWS private route destination cidr blocks | `string` | `"0.0.0.0/0"` | no |
| <a name="input_public_route_destination_cidr_block"></a> [public\_route\_destination\_cidr\_block](#input\_public\_route\_destination\_cidr\_block) | AWS public route destination cidr blocks | `string` | `"0.0.0.0/0"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPC  cidr blocks | `string` | `"172.17.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_private_subnet_cidr_block"></a> [aws\_private\_subnet\_cidr\_block](#output\_aws\_private\_subnet\_cidr\_block) | Private subnet cidr blocks |
| <a name="output_aws_public_subnet_id"></a> [aws\_public\_subnet\_id](#output\_aws\_public\_subnet\_id) | Public subnet id |
| <a name="output_rds_subnet_group_id"></a> [rds\_subnet\_group\_id](#output\_rds\_subnet\_group\_id) | Subnet group id for RDS |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC id |
<!-- END_TF_DOCS -->
