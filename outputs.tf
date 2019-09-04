/*  #########################################################################

    ATTENTION: This file uses the old Terraform 0.11 syntax on purpose
    => do NOT upgrade to Terraform 0.12 syntax
    (see docs/developer/Development for details)

    ######################################################################### */

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

output "availability_zone" {
  description = "List of availability zones of instances"
  value       = "${local.this_availability_zone}"
}

output "credit_specification" {
  description = "List of credit specification of instances"
  value       = "${local.this_credit_specification}"
}

output "id" {
  description = "List of IDs of instances"
  value       = "${local.this_id}"
}

output "key_name" {
  description = "List of key names of instances"
  value       = "${local.this_key_name}"
}

output "password_data" {
  description = "List of Base-64 encoded encrypted password data for the instance"
  value       = "${local.this_password_data}"
}

output "placement_group" {
  description = "List of placement groups of instances"
  value       = "${local.this_placement_group}"
}

output "primary_network_interface_id" {
  description = "List of IDs of the primary network interface of instances"
  value       = "${local.this_primary_network_interface_id}"
}

output "private_dns" {
  description = "List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = "${local.this_private_dns}"
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = "${local.this_private_ip}"
}

output "public_dns" {
  description = "List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = "${local.this_public_dns}"
}

output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = "${local.this_public_ip}"
}

output "security_groups" {
  description = "List of associated security groups of instances"
  value       = "${local.this_security_groups}"
}

output "subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value       = "${local.this_subnet_id}"
}

output "tags" {
  description = "List of tags of instances"
  value       = "${local.this_tags}"
}

output "volume_tags" {
  description = "List of tags of volumes of instances"
  value       = "${local.this_volume_tags}"
}

output "vpc_security_group_ids" {
  description = "List of associated security groups of instances, if running in non-default VPC"
  value       = "${local.this_vpc_security_group_ids}"
}
