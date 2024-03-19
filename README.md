## Requirements

| Name                                                                      | Version  |
| ------------------------------------------------------------------------- | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws)                   | ~> 5.0   |

## Providers

No providers.

## Modules

| Name                                                                                                    | Source        | Version |
| ------------------------------------------------------------------------------------------------------- | ------------- | ------- |
| <a name="module_api-gateway"></a> [api-gateway](#module\_api-gateway)                                   | ./api-gateway | n/a     |
| <a name="module_ec2"></a> [ec2](#module\_ec2)                                                           | ./ec2         | n/a     |
| <a name="module_network"></a> [network](#module\_network)                                               | ./network     | n/a     |
| <a name="module_rds"></a> [rds](#module\_rds)                                                           | ./rds         | n/a     |
| <a name="module_rds_security_group"></a> [rds\_security\_group](#module\_rds\_security\_group)          | ./security    | n/a     |
| <a name="module_server_security_group"></a> [server\_security\_group](#module\_server\_security\_group) | ./security    | n/a     |

## Resources

No resources.

## Inputs

| Name                                                                                         | Description                                            | Type           | Default | Required |
| -------------------------------------------------------------------------------------------- | ------------------------------------------------------ | -------------- | ------- | :------: |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name)                                 | Application Name                                       | `string`       | n/a     |   yes    |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region)                           | Aws Region for resource creation                       | `string`       | n/a     |   yes    |
| <a name="input_az_count"></a> [az\_count](#input\_az\_count)                                 | Number of AZs to cover in a given region               | `string`       | n/a     |   yes    |
| <a name="input_credentials"></a> [credentials](#input\_credentials)                          | Credential File Location                               | `string`       | n/a     |   yes    |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name)                                    | Database name                                          | `string`       | n/a     |   yes    |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password)                        | Password to access database.                           | `string`       | n/a     |   yes    |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user)                                    | Postgres database username                             | `string`       | n/a     |   yes    |
| <a name="input_ec2_instance_type"></a> [ec2\_instance\_type](#input\_ec2\_instance\_type)    | Instance type                                          | `string`       | n/a     |   yes    |
| <a name="input_environment"></a> [environment](#input\_environment)                          | Deployment Server Environment Name: prod/staging/dev   | `string`       | n/a     |   yes    |
| <a name="input_git_pat_token"></a> [git\_pat\_token](#input\_git\_pat\_token)                | Github Token of your github project repository owner : | `string`       | n/a     |   yes    |
| <a name="input_ingress_ports"></a> [ingress\_ports](#input\_ingress\_ports)                  | Inbound ports to be opened.                            | `list(number)` | n/a     |   yes    |
| <a name="input_instance_ami"></a> [instance\_ami](#input\_instance\_ami)                     | Instance ami                                           | `string`       | n/a     |   yes    |
| <a name="input_instance_disk_size"></a> [instance\_disk\_size](#input\_instance\_disk\_size) | Instance Disk size in GB                               | `string`       | `""`    |    no    |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name)                  | Instance Name                                          | `string`       | `""`    |    no    |
| <a name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | Instance class used for RDS.                           | `string`       | n/a     |   yes    |
| <a name="input_repo_name"></a> [repo\_name](#input\_repo\_name)                              | Name of your github project repository :               | `string`       | n/a     |   yes    |
| <a name="input_repo_owner"></a> [repo\_owner](#input\_repo\_owner)                           | name of the Github Repository Owner :                  | `string`       | n/a     |   yes    |
| <a name="input_rsa_key_1"></a> [rsa\_key\_1](#input\_rsa\_key\_1)                            | Public rsa key 1st                                     | `string`       | `""`    |    no    |
| <a name="input_rsa_key_2"></a> [rsa\_key\_2](#input\_rsa\_key\_2)                            | Public rsa key 2nd                                     | `string`       | `""`    |    no    |
| <a name="input_ssh_private_key"></a> [ssh\_private\_key](#input\_ssh\_private\_key)          | Private key                                            | `string`       | `""`    |    no    |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key)             | Public key                                             | `string`       | `""`    |    no    |
| <a name="input_update_ssh_key"></a> [update\_ssh\_key](#input\_update\_ssh\_key)             | Update ssh key value.                                  | `string`       | `""`    |    no    |

## Outputs

| Name                                                                                          | Description                          |
| --------------------------------------------------------------------------------------------- | ------------------------------------ |
| <a name="output_api_gw_invoke_url"></a> [api\_gw\_invoke\_url](#output\_api\_gw\_invoke\_url) | Public url to access api gateway     |
| <a name="output_app_env"></a> [app\_env](#output\_app\_env)                                   | App environment                      |
| <a name="output_ec2_server_ip"></a> [ec2\_server\_ip](#output\_ec2\_server\_ip)               | Elastic IP attached with EC2 server. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id)                                      | The ID of the VPC                    |
