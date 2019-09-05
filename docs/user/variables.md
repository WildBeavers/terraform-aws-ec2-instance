## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ami | ID of AMI to use for the instance | string | n/a | yes |
| instance_type | The type of instance to start | string | n/a | yes |
| name | Name to be used on all resources as prefix | string | n/a | yes |
| vpc_security_group_ids | A list of security group IDs to associate with | list(string) | n/a | yes |
| associate_public_ip_address | If true, the EC2 instance will have associated public IP address | bool | `"false"` | no |
| attached_block_device | List of additional EBS block devices to attach after an instance     has been created. Either use this variable or `ebs_block_device`,     but not both.<br><br>    Each element of the list supports the following volume configuration items     (provided as a map):<br><br>    * `encrypted`<br>     * `iops`<br>     * `kms_key_id`<br>     * `volume_size`<br>     * `snapshot_id`<br>     * `volume_type`<br><br><br>    For a description of the configration items see     [aws_ebs_volume](https://www.terraform.io/docs/providers/aws/r/ebs_volume.html#argument-reference)<br><br>    Additionally the following config item exists:<br><br>    * `volume_tag_name_suffix` - suffix which is appended to the hostname and used for the `Name` tag of the volume | list(map(string)) | `[]` | no |
| cpu_credits | The credit option for CPU usage (unlimited or standard) | string | `"standard"` | no |
| disable_api_termination | If true, enables EC2 Instance Termination Protection | bool | `"false"` | no |
| ebs_block_device | List of EBS block devices to attach to the instance.     Either use this variable or `attached_block_device` but not both.<br><br>    Each element of the list supports the following volume configuration items     (provided as a map):<br><br>    * `delete_on_termination`<br>     * `device_name`<br>     * `encrypted`<br>     * `iops`<br>     * `snapshot_id`<br>     * `volume_size`<br>     * `volume_type`<br><br><br>    For a description of the configration items see     [Block devices](https://www.terraform.io/docs/providers/aws/r/instance.html#block-devices)     (section `ebs_block_device`) | list(map(string)) | `[]` | no |
| ebs_optimized | If true, the launched EC2 instance will be EBS-optimized | bool | `"false"` | no |
| ephemeral_block_device | List of Ephemeral (also known as Instance Store) volumes on the instance.<br><br>    Each element of the list supports the following volume configuration items     (provided as a map):<br><br>    * `device_name`<br>     * `no_device`<br>     * `virtual_name`<br><br><br>    For a description of the configration items see     [Block devices](https://www.terraform.io/docs/providers/aws/r/instance.html#block-devices)     (section `ephemeral_block_device`) | list(map(string)) | `[]` | no |
| get_password_data | If true, wait for password data to become available and retrieve it. | bool | `"false"` | no |
| hostname_formatstring | Format string for generating the hostname of an instance.     The `name` and instance count are used as parameters.<br><br>    The [Specification Syntax](https://www.terraform.io/docs/configuration/functions/format.html)     contains a description of formatting sequences.     It is important that a valid padding character is used     in order to prevent space(s) in the hostname     (e.g. use `"%s-%02d"` but __not__ `"%s-%2d"`)<br><br>    This value is only used when `use_num_suffix==true` or     more than one instance is created. | string | `"%s-%d"` | no |
| iam_instance_profile | The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. | string | `""` | no |
| instance_count | Number of instances to launch | number | `"1"` | no |
| instance_initiated_shutdown_behavior | Shutdown behavior for the instance | string | `""` | no |
| ipv6_address_count | A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet. | number | `"0"` | no |
| ipv6_addresses | Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface | list(string) | `[]` | no |
| key_name | The key name to use for the instance | string | `""` | no |
| monitoring | If true, the launched EC2 instance will have detailed monitoring enabled | bool | `"false"` | no |
| network_interface | Customize network interfaces to be attached at instance boot time | list(map(string)) | `[]` | no |
| placement_group | The Placement Group to start the instance in | string | `""` | no |
| private_ip | Private IP address to associate with the instance in a VPC | string | `""` | no |
| private_ips | A list of private IP address to associate with the instance in a VPC. Should match the number of instances. | list(string) | `[]` | no |
| root_block_device | Customize details about the root block device of the instance(s).     The list must contain zero or one entries     (more than one root device is not allowed).<br><br>    Each element of the list supports the following volume configuration items     (provided as a map):<br><br>    * `delete_on_termination`<br>     * `iops`<br>     * `volume_size`<br>     * `volume_type`<br><br><br>    For a description of the configration items see     [Block devices](https://www.terraform.io/docs/providers/aws/r/instance.html#block-devices)     (section `root_block_device`) | list(map(string)) | `[]` | no |
| source_dest_check | Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs. | bool | `"true"` | no |
| subnet_id | The VPC Subnet ID to launch in | string | `""` | no |
| subnet_ids | A list of VPC Subnet IDs to launch in | list(string) | `[]` | no |
| tags | A mapping of tags to assign to the resource | map(string) | `{}` | no |
| tenancy | The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host. | string | `"default"` | no |
| use_num_suffix | Always append numerical suffix to instance name, even if instance_count is 1 | bool | `"false"` | no |
| user_data | The user data to provide when launching the instance.<br><br>    For each instance a separate user_data is generated and the variable     `hostname` is replaced by the generated instance name.     In the string, the variable must be preceded by a dollar sign     and enclosed in curly brackets     (`$hostname` and `{hostname}` are __not__ replaced). | string | `""` | no |
| volume_tag_name_suffix | A `Name` tag with the hostname is automatically added to the `volume_tags`.     This variable allows to configure a suffix which appended.<br><br>    Remark: The same suffix is used for th following device types:     `root_block_device`, `ebs_block_device` and `ephemeral_block_device`.     It is not possible to specify a different suffix for each volume (only     `attached_block_device` supports this). | string | `""` | no |
| volume_tags | A mapping of tags to assign to the devices created by the instance at launch time | map(string) | `{}` | no |

