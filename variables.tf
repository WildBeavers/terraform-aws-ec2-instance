/*  #########################################################################
    Input variables of the module
    ######################################################################### */

variable "ami" {
  description = <<EOF
ID of AMI to use for the instance.
  EOF
  type        = string
}

variable "associate_public_ip_address" {
  description = <<EOF
If true, the EC2 instance will get a public IP address
(changing this attribute triggers re-creation).
  EOF
  type        = bool
  default     = false
}

variable "attached_block_device" {
  description = <<EOF
List of additional EBS block devices to attach after an instance
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
  EOF
  type        = list(map(string))
  default     = []
}

variable "cpu_credits" {
  description = <<EOF
The credit option for CPU usage (unlimited or standard).
  EOF
  type        = string
  default     = "standard"
}

variable "disable_api_termination" {
  description = <<EOF
If true, enables EC2 Instance Termination Protection.
  EOF
  type        = bool
  default     = false
}

variable "ebs_block_device" {
  description = <<EOF
(DEPRECATED)
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
  EOF
  type        = list(map(string))
  default     = []
}

variable "ebs_optimized" {
  description = <<EOF
If true, the launched EC2 instance(s) will be EBS-optimized.
  EOF
  type        = bool
  default     = false
}

variable "ephemeral_block_device" {
  description = <<EOF
List of Ephemeral (also known as Instance Store) volumes on the instance.

Each element of the list supports the following volume configuration
attributes (provided as a map):

* `device_name`
* `no_device`
* `virtual_name`

For a description of the configuration attributes and their default values
see [Block devices](https://www.terraform.io/docs/providers/aws/r/instance.html#block-devices)
(section `ephemeral_block_device`)
  EOF
  type        = list(map(string))
  default     = []
}

variable "get_password_data" {
  description = <<EOF
If true, wait for password data to become available and retrieve it.
  EOF
  type        = bool
  default     = false
}

variable "hostname_formatstring" {
  description = <<EOF
Format string for generating the hostname of an instance.
The `name` and instance count are used as parameters.

The [Specification Syntax](https://www.terraform.io/docs/configuration/functions/format.html)
contains a description of formatting sequences.
It is important that a valid padding character is used
in order to prevent space(s) in the hostname
(e.g. use `"%s-%02d"` but __not__ `"%s-%2d"`)

This value is only used when `use_num_suffix==true` or
more than one instance is created.
  EOF
  type        = string
  default     = "%s-%d"
}

variable "iam_instance_profile" {
  description = <<EOF
The IAM Instance Profile to launch the instance with.
Specified as the name of the Instance Profile.
  EOF
  type        = string
  default     = null
}

variable "instance_count" {
  description = <<EOF
Number of instances to launch.
  EOF
  type        = number
  default     = 1
}

variable "instance_initiated_shutdown_behavior" {
  description = <<EOF
Shutdown behavior for the instance
(for details see [Changing the Instance Initiated Shutdown Behavior](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior)).
  EOF
  type        = string
  default     = null
}

variable "instance_private_dns_record" {
  type = object({
    domain         = string
    hosted_zone_id = string
    ttl            = string
  })

  description = <<EOF
Mapping to configure private dns records.

The mapping must contain the following configuration attributes:

* `domain`
* `hosted_zone_id`
* `ttl`

For a description of the configuration attributes see resource:
[aws_route53_record](https://www.terraform.io/docs/providers/aws/r/route53_record.html#argument-reference)
  EOF
  default     = null
}

variable "instance_tags" {
  description = <<EOF
A mapping of tags that are assigned to the EC2 instance(s).
  EOF
  type        = map(string)
  default     = {}
}

variable "instance_type" {
  description = <<EOF
The type of instance to start.
  EOF
  type        = string
}

variable "ipv6_address_count" {
  description = <<EOF
A number of IPv6 addresses to associate with the primary network interface.
Amazon EC2 chooses the IPv6 addresses from the range of your subnet.
  EOF
  type        = number
  default     = 0
}

variable "ipv6_addresses" {
  description = <<EOF
Specify one or more IPv6 addresses from the range of the subnet
to associate with the primary network interface.
  EOF
  type        = list(string)
  default     = null
}

variable "key_name" {
  description = <<EOF
The name of the SSH key to use for the instance.
The key must exist at the region where the instance is launched.
  EOF
  type        = string
  default     = ""
}

variable "monitoring" {
  description = <<EOF
If true, the launched EC2 instance will have detailed monitoring enabled.
  EOF
  type        = bool
  default     = false
}

variable "name" {
  description = <<EOF
Name to be used on all resources as prefix
  EOF
  type        = string
}

variable "placement_group" {
  description = <<EOF
The Placement Group to start the instance in
  EOF
  type        = string
  default     = null
}

variable "private_ips" {
  description = <<EOF
A list of private IP address to associate with the instance in a VPC.
Should match the number of instances.
  EOF
  type        = list(string)
  default     = []
}

variable "root_block_device" {
  description = <<EOF
Customize details about the root block device of the instance(s).
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
  EOF
  type        = list(map(string))
  default     = []
}

variable "source_dest_check" {
  description = <<EOF
Controls if traffic is routed to the instance when the destination address
does not match the instance. Used for NAT or VPNs.
  EOF
  type        = bool
  default     = true
}

variable "subnet_ids" {
  description = <<EOF
A list of VPC Subnet IDs to launch in.
  EOF
  type        = list(string)
}

variable "tags" {
  description = <<EOF
A mapping of tags, which are assigned to all resources which are created
by this module.
  EOF
  type        = map(string)
  default     = {}
}

variable "tenancy" {
  description = <<EOF
The tenancy of the instance (if the instance is running in a VPC).
Available values:

* default
* dedicated
* host
  EOF
  type        = string
  default     = "default"
}

variable "use_num_suffix" {
  description = <<EOF
Always append numerical suffix to instance name,
even if instance_count is 1.
  EOF
  type        = bool
  default     = false
}

variable "user_data" {
  description = <<EOF
The user data to provide when launching the instance.

For each instance a separate user_data is generated and the variable
`hostname` is replaced by the generated instance name.
In the string, the variable must be preceded by a dollar sign
and enclosed in curly brackets
(`$hostname` and `{hostname}` are __not__ replaced).
  EOF
  type        = string
  default     = ""
}

variable "volume_tags" {
  description = <<EOF
A mapping of tags that are assigned to all volume.
  EOF
  type        = map(string)
  default     = {}
}

variable "vpc_security_group_ids" {
  description = <<EOF
A list of security group IDs to associate with the EC2 instance(s)
  EOF
  type        = list(string)
  default     = null
}
