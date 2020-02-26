# Required Inputs

The following input variables are required:

## ami

Description: ID of AMI to use for the instance.

Type: `string`

## iam_instance_profile

Description: The IAM Instance Profile to launch the instance with.
Specified as the name of the Instance Profile.

Type: `string`

## instance_initiated_shutdown_behavior

Description: Shutdown behavior for the instance
(for details see [Changing the Instance Initiated Shutdown Behavior](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior)).

Type: `string`

## instance_private_dns_record

Description: Mapping to configure private dns records.

The mapping must contain the following configuration attributes:

* `domain`
* `hosted_zone_id`
* `ttl`

For a description of the configuration attributes see resource:
[aws_route53_record](https://www.terraform.io/docs/providers/aws/r/route53_record.html#argument-reference)

Type:

```hcl
object({
    domain         = string
    hosted_zone_id = string
    ttl            = string
  })
```

## instance_type

Description: The type of instance to start.

Type: `string`

## ipv6_addresses

Description: Specify one or more IPv6 addresses from the range of the subnet
to associate with the primary network interface.

Type: `list(string)`

## name

Description: Name to be used on all resources as prefix

Type: `string`

## placement_group

Description: The Placement Group to start the instance in

Type: `string`

## subnet_ids

Description: A list of VPC Subnet IDs to launch in.

Type: `list(string)`

## vpc_security_group_ids

Description: A list of security group IDs to associate with the EC2 instance(s)

Type: `list(string)`

# Optional Inputs

The following input variables are optional (have default values):

## associate_public_ip_address

Description: If true, the EC2 instance will get a public IP address
(changing this attribute triggers re-creation).

Type: `bool`

Default: `false`

## attached_block_device

Description: List of additional EBS block devices to attach after an instance
has been created. Use this variable instead of `ebs_block_device`.

Each element of the list supports the following volume configuration
attributes (provided as a map):

* `encrypted` - boolean (changing this attribute triggers re-creation)
* (optional) `iops`
* (optional) `kms_key_id`
* (optional) `snapshot_id`
* (optional) `volume_size`
* (optional) `volume_type`

For a description of the configuration attributes and their default values
see [aws_ebs_volume](https://www.terraform.io/docs/providers/aws/r/ebs_volume.html#argument-reference)

Additionally the following config attributes are required:

* (required) `device_name` - the device name to expose to the instance
* (required) `volume_name` - name of volume (must be unique across all block devive)

Type: `list(map(string))`

Default: `[]`

## cpu_credits

Description: The credit option for CPU usage (unlimited or standard).

Type: `string`

Default: `"standard"`

## disable_api_termination

Description: If true, enables EC2 Instance Termination Protection.

Type: `bool`

Default: `false`

## ebs_block_device

Description: (DEPRECATED)
List of EBS block devices to attach to the instance.
This variable is provided due to backward compatibility.
Use instead variable `attached_block_device`.

Each element of the list supports the following volume configuration
attributes (provided as a map):

* `delete_on_termination` - boolean
* `device_name`
* `encrypted` - boolean (changing this attribute triggers re-creation)
* `iops`
* `kms_key_id`
* `snapshot_id`
* `volume_size`
* `volume_type`

For a description of the configuration attributes and their default values
see [Block devices](https://www.terraform.io/docs/providers/aws/r/instance.html#block-devices)
(section `ebs_block_device`)

Type: `list(map(string))`

Default: `[]`

## ebs_optimized

Description: If true, the launched EC2 instance(s) will be EBS-optimized.

Type: `bool`

Default: `false`

## ephemeral_block_device

Description: List of Ephemeral (also known as Instance Store) volumes on the instance.

Each element of the list supports the following volume configuration
attributes (provided as a map):

* `device_name`
* `no_device`
* `virtual_name`

For a description of the configuration attributes and their default values
see [Block devices](https://www.terraform.io/docs/providers/aws/r/instance.html#block-devices)
(section `ephemeral_block_device`)

Type: `list(map(string))`

Default: `[]`

## get_password_data

Description: If true, wait for password data to become available and retrieve it.

Type: `bool`

Default: `false`

## hostname_formatstring

Description: Format string for generating the hostname of an instance.
The `name` and instance count are used as parameters.

The [Specification Syntax](https://www.terraform.io/docs/configuration/functions/format.html)
contains a description of formatting sequences.
It is important that a valid padding character is used
in order to prevent space(s) in the hostname
(e.g. use `"%s-%02d"` but __not__ `"%s-%2d"`)

This value is only used when `use_num_suffix==true` or
more than one instance is created.

Type: `string`

Default: `"%s-%d"`

## instance_count

Description: Number of instances to launch.

Type: `number`

Default: `1`

## instance_tags

Description: A mapping of tags that are assigned to the EC2 instance(s).

Type: `map(string)`

Default: `{}`

## ipv6_address_count

Description: A number of IPv6 addresses to associate with the primary network interface.
Amazon EC2 chooses the IPv6 addresses from the range of your subnet.

Type: `number`

Default: `0`

## key_name

Description: The name of the SSh key to use for the instance.
The key must exist at the region where the instance is launched.

Type: `string`

Default: `""`

## monitoring

Description: If true, the launched EC2 instance will have detailed monitoring enabled.

Type: `bool`

Default: `false`

## private_ips

Description: A list of private IP address to associate with the instance in a VPC.
Should match the number of instances.

Type: `list(string)`

Default: `[]`

## root_block_device

Description: Customize details about the root block device of the instance(s).
The list must contain zero or one entries
(more than one root device is not allowed).

Each element of the list supports the following volume configuration
attributes (provided as a map):

* `delete_on_termination` - boolean
* `encrypted` - boolean (changing this attribute triggers re-creation)
* `kms_key_id`
* `iops`
* `volume_size`
* `volume_type`

For a description of the configuration attributes and their default values
see [Block devices](https://www.terraform.io/docs/providers/aws/r/instance.html#block-devices)
(section `root_block_device`)

Type: `list(map(string))`

Default: `[]`

## source_dest_check

Description: Controls if traffic is routed to the instance when the destination address
does not match the instance. Used for NAT or VPNs.

Type: `bool`

Default: `true`

## tags

Description: A mapping of tags, which are assigned to all resources which are created
by this module.

Type: `map(string)`

Default: `{}`

## tenancy

Description: The tenancy of the instance (if the instance is running in a VPC).
Available values:

* default
* dedicated
* host

Type: `string`

Default: `"default"`

## use_num_suffix

Description: Always append numerical suffix to instance name,
even if instance_count is 1.

Type: `bool`

Default: `false`

## user_data

Description: The user data to provide when launching the instance.

For each instance a separate user_data is generated and the variable
`hostname` is replaced by the generated instance name.
In the string, the variable must be preceded by a dollar sign
and enclosed in curly brackets
(`$hostname` and `{hostname}` are __not__ replaced).

Type: `string`

Default: `""`

## volume_tags

Description: A mapping of tags that are assigned to all volume.

Type: `map(string)`

Default: `{}`

