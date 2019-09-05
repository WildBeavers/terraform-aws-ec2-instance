variable "name" {
  description = "Name to be used on all resources as prefix"
  type        = string
}

variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
}

variable "placement_group" {
  description = "The Placement Group to start the instance in"
  type        = string
  default     = ""
}

variable "get_password_data" {
  description = "If true, wait for password data to become available and retrieve it."
  type        = bool
  default     = false
}

variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host."
  type        = string
  default     = "default"
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = false
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  type        = bool
  default     = false
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance" # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = ""
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = false
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "A list of VPC Subnet IDs to launch in"
  type        = list(string)
  default     = []
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  type        = bool
  default     = false
}

variable "private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  type        = string
  default     = ""
}

variable "private_ips" {
  description = "A list of private IP address to associate with the instance in a VPC. Should match the number of instances."
  type        = list(string)
  default     = []
}

variable "source_dest_check" {
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs."
  type        = bool
  default     = true
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

variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
  type        = string
  default     = ""
}

variable "ipv6_address_count" {
  description = "A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet."
  type        = number
  default     = 0
}

variable "ipv6_addresses" {
  description = "Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  type        = map(string)
  default     = {}
}
variable "volume_tag_name_suffix" {
  description = <<EOF
    A `Name` tag with the hostname is automatically added to the `volume_tags`.
    This variable allows to configure a suffix which appended.

    Remark: The same suffix is used for th following device types:
    `root_block_device`, `ebs_block_device` and `ephemeral_block_device`.
    It is not possible to specify a different suffix for each volume (only
    `attached_block_device` supports this).
  EOF
  type        = string
  default     = ""
}

variable "root_block_device" {
  description = <<EOF
    Customize details about the root block device of the instance(s).
    The list must contain zero or one entries
    (more than one root device is not allowed).

    Each element of the list supports the following volume configuration items
    (provided as a map):

    * `delete_on_termination`<br>
    * `iops`<br>
    * `volume_size`<br>
    * `volume_type`<br>

    For a description of the configration items see
    [Block devices](https://www.terraform.io/docs/providers/aws/r/instance.html#block-devices)
    (section `root_block_device`)
  EOF
  type        = list(map(string))
  default     = []
}

variable "attached_block_device" {
  description = <<EOF
    List of additional EBS block devices to attach after an instance
    has been created. Either use this variable or `ebs_block_device`,
    but not both.

    Each element of the list supports the following volume configuration items
    (provided as a map):

    * `encrypted`<br>
    * `iops`<br>
    * `kms_key_id`<br>
    * `volume_size`<br>
    * `snapshot_id`<br>
    * `volume_type`<br>

    For a description of the configration items see
    [aws_ebs_volume](https://www.terraform.io/docs/providers/aws/r/ebs_volume.html#argument-reference)

    Additionally the following config item exists:

    * `volume_tag_name_suffix` - suffix which is appended to the hostname and used for the `Name` tag of the volume
  EOF
  type        = list(map(string))
  default     = []
}

variable "ebs_block_device" {
  description = <<EOF
    List of EBS block devices to attach to the instance.
    Either use this variable or `attached_block_device` but not both.

    Each element of the list supports the following volume configuration items
    (provided as a map):

    * `delete_on_termination`<br>
    * `device_name`<br>
    * `encrypted`<br>
    * `iops`<br>
    * `snapshot_id`<br>
    * `volume_size`<br>
    * `volume_type`<br>

    For a description of the configration items see
    [Block devices](https://www.terraform.io/docs/providers/aws/r/instance.html#block-devices)
    (section `ebs_block_device`)
  EOF
  type        = list(map(string))
  default     = []
}

variable "ephemeral_block_device" {
  description = <<EOF
    List of Ephemeral (also known as Instance Store) volumes on the instance.

    Each element of the list supports the following volume configuration items
    (provided as a map):

    * `device_name`<br>
    * `no_device`<br>
    * `virtual_name`<br>

    For a description of the configration items see
    [Block devices](https://www.terraform.io/docs/providers/aws/r/instance.html#block-devices)
    (section `ephemeral_block_device`)
  EOF
  type        = list(map(string))
  default     = []
}

variable "network_interface" {
  description = "Customize network interfaces to be attached at instance boot time"
  type        = list(map(string))
  default     = []
}

variable "cpu_credits" {
  description = "The credit option for CPU usage (unlimited or standard)"
  type        = string
  default     = "standard"
}

variable "use_num_suffix" {
  description = "Always append numerical suffix to instance name, even if instance_count is 1"
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
