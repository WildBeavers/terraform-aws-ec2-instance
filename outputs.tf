/*  #########################################################################

    ATTENTION: This file uses the old Terraform 0.11 syntax on purpose
    => do NOT upgrade to Terraform 0.12 syntax
    (see docs/developer/Development for details)

    ######################################################################### */

/*  -------------------------------------------------------------------------
    Deprecated Locals

    The following Locals are deprecated. They all can be replaced by
    referencing the `instances` Output.
    ------------------------------------------------------------------------- */
locals {
  this_availability_zone            = "${compact(coalescelist(aws_instance.this.*.availability_zone, [""]))}"
  this_credit_specification         = "${flatten(aws_instance.this.*.credit_specification)}"
  this_id                           = "${compact(coalescelist(aws_instance.this.*.id, [""]))}"
  this_key_name                     = "${compact(coalescelist(aws_instance.this.*.key_name, [""]))}"
  this_password_data                = "${coalescelist(aws_instance.this.*.password_data, [""])}"
  this_placement_group              = "${compact(coalescelist(aws_instance.this.*.placement_group, [""]))}"
  this_primary_network_interface_id = "${compact(coalescelist(aws_instance.this.*.primary_network_interface_id, [""]))}"
  this_private_dns                  = "${compact(coalescelist(aws_instance.this.*.private_dns, [""]))}"
  this_private_ip                   = "${compact(coalescelist(aws_instance.this.*.private_ip, [""]))}"
  this_public_dns                   = "${compact(coalescelist(aws_instance.this.*.public_dns, [""]))}"
  this_public_ip                    = "${compact(coalescelist(aws_instance.this.*.public_ip, [""]))}"
  this_security_groups              = "${coalescelist(aws_instance.this.*.security_groups, [""])}"
  this_subnet_id                    = "${compact(coalescelist(aws_instance.this.*.subnet_id, [""]))}"
  this_tags                         = "${coalescelist(aws_instance.this.*.tags, [""])}"
  this_volume_tags                  = "${coalescelist(aws_instance.this.*.volume_tags, [""])}"
  this_vpc_security_group_ids       = "${coalescelist(flatten(aws_instance.this.*.vpc_security_group_ids), [""])}"
}

/*  -------------------------------------------------------------------------
    Deprecated Outputs

    The following Outputs are deprecated. They all can be replaced by
    referencing the `instances` Output. Examples for a drop-in replacement
    have been added to each deprecated Output.
    ------------------------------------------------------------------------- */

output "availability_zone" {
  description = <<EOF
    (DEPRECATED)
    List of availability zones of instances

    Deprecation Notice:
      To continue using this value, like in earlier versions, please use the
      following expression:
      module.module_name.instances.*.availability_zone
  EOF

  value = "${local.this_availability_zone}"
}

output "credit_specification" {
  description = <<EOF
    (DEPRECATED)
    List of credit specification of instances

    Deprecation Notice:
      To continue using this value, like in earlier versions, please use the
      following expression:
      ${flatten(module.module_name.instances.*.credit_specification)}
  EOF

  value = "${local.this_credit_specification}"
}

output "id" {
  description = <<EOF
    (DEPRECATED)
    List of IDs of instances

    Deprecation Notice:
      To continue using this value, like in earlier versions, please use the
      following expression:
      module.module_name.instances.*.id
  EOF

  value = "${local.this_id}"
}

output "key_name" {
  description = <<EOF
    (DEPRECATED)
    List of key names of instances

    Deprecation Notice:
      To continue using this value, like in earlier versions, please use the
      following expression:
      module.module_name.instances.*.key_name
  EOF

  value = "${local.this_key_name}"
}

output "password_data" {
  description = <<EOF
    (DEPRECATED)
    List of Base-64 encoded encrypted password data for the instance

    Deprecation Notice:
      To continue using this value, like in earlier versions, please use the
      following expression:
      module.module_name.instances.*.password_data
  EOF

  value = "${local.this_password_data}"
}

output "placement_group" {
  description = <<EOF
    (DEPRECATED)
    List of placement groups of instances

    Deprecation Notice:
      To continue using this value, like in earlier versions, please use the
      following expression:
      compact(module.module_name.instances.*.placement_group)
  EOF

  value = "${local.this_placement_group}"
}

output "primary_network_interface_id" {
  description = <<EOF
    (DEPRECATED)
    List of IDs of the primary network interface of instances

    Deprecation Notice:
      To continue using this value, like in earlier versions, please use the
      following expression:
      module.module_name.instances.*.primary_network_interface_id
  EOF

  value = "${local.this_primary_network_interface_id}"
}

output "private_dns" {
  description = <<EOF
    (DEPRECATED)
    List of private DNS names assigned to the instances. Can only be used
      inside the Amazon EC2, and only available if you've enabled DNS
      hostnames for your VPC

    Deprecation Notice:
      To continue using this value, like in earlier versions, please use the
      following expression:
      module.module_name.instances.*.private_dns
  EOF

  value = "${local.this_private_dns}"
}

output "private_ip" {
  description = <<EOF
    (DEPRECATED)
    List of private IP addresses assigned to the instances

    Deprecation Notice:
      To continue using this value, like in earlier versions, please use the
      following expression:
      module.module_name.instances.*.private_ip
  EOF

  value = "${local.this_private_ip}"
}

output "public_dns" {
  description = <<EOF
    (DEPRECATED)
    List of public DNS names assigned to the instances. For EC2-VPC, this is
      only available if you've enabled DNS hostnames for your VPC

    Deprecation Notice:
      To continue using this value, like in earlier versions, please use the
      following expression:
      compact(module.module_name.instances.*.public_dns)
  EOF

  value = "${local.this_public_dns}"
}

output "public_ip" {
  description = <<EOF
    (DEPRECATED)
    List of public IP addresses assigned to the instances, if applicable

    Deprecation Notice:
      To continue using this value, like in earlier versions, please use the
      following expression:
      compact(module.module_name.instances.*.public_ip)
  EOF

  value = "${local.this_public_ip}"
}

output "security_groups" {
  description = <<EOF
    (DEPRECATED)
    List of associated security groups of instances

    Deprecation Notice:
      To continue using this value, like in earlier versions, please use the
      following expression:
      module.module_name.instances.*.security_groups
  EOF

  value = "${local.this_security_groups}"
}

output "subnet_id" {
  description = <<EOF
    (DEPRECATED)
    List of IDs of VPC subnets of instances

    Deprecation Notice:
      To continue using this value, like in earlier versions, please use the
      following expression:
      module.module_name.instances.*.subnet_id
  EOF

  value = "${local.this_subnet_id}"
}

output "tags" {
  description = <<EOF
    (DEPRECATED)
    List of tags of instances

    Deprecation Notice:
      To continue using this value, like in earlier versions, please use the
      following expression:
      module.module_name.instances.*.tags
  EOF

  value = "${local.this_tags}"
}

output "volume_tags" {
  description = <<EOF
    (DEPRECATED)
    List of tags of volumes of instances

    Deprecation Notice:
      To continue using this value, like in earlier versions, please use the
      following expression:
      module.module_name.instances.*.volume_tags
  EOF

  value = "${local.this_volume_tags}"
}

output "vpc_security_group_ids" {
  description = <<EOF
    (DEPRECATED)
    List of associated security groups of instances,
      if running  in non-default VPC

    Deprecation Notice:
      To continue using this value, like in earlier versions, please use the
      following expression:
      flatten(module.module_name.instances.*.vpc_security_group_ids)
  EOF

  value = "${local.this_vpc_security_group_ids}"
}
