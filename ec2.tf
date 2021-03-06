/*  #########################################################################
    Create EC2 instance(s)
    ######################################################################### */

resource "aws_instance" "this" {
  count = var.instance_count

  ami                                  = var.ami
  associate_public_ip_address          = var.associate_public_ip_address
  disable_api_termination              = var.disable_api_termination
  ebs_optimized                        = var.ebs_optimized
  get_password_data                    = var.get_password_data
  iam_instance_profile                 = var.iam_instance_profile
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  instance_type                        = var.instance_type
  ipv6_address_count                   = var.ipv6_address_count
  ipv6_addresses                       = var.ipv6_addresses
  key_name                             = var.key_name
  monitoring                           = var.monitoring
  placement_group                      = var.placement_group
  private_ip                           = length(var.private_ips) > 0 ? var.private_ips[count.index] : ""
  source_dest_check                    = var.source_dest_check
  subnet_id                            = var.subnet_ids[count.index % length(var.subnet_ids)]
  tenancy                              = var.tenancy
  user_data                            = data.template_file.user_data[count.index].rendered
  vpc_security_group_ids               = var.vpc_security_group_ids

  credit_specification {
    cpu_credits = local.is_t_instance_type ? var.cpu_credits : null
  }

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
    }
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = lookup(ebs_block_device.value, "device_name", null)
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
    }
  }

  dynamic "ephemeral_block_device" {
    for_each = var.ephemeral_block_device
    content {
      device_name  = ephemeral_block_device.value.device_name
      no_device    = lookup(ephemeral_block_device.value, "no_device", null)
      virtual_name = lookup(ephemeral_block_device.value, "virtual_name", null)
    }
  }

  tags = merge(
    {
      Name = local.hostnames[count.index]
    },
    var.tags,
    var.instance_tags
  )

  volume_tags = merge(
    {
      Name = local.hostnames[count.index]
    },
    var.volume_tags,
  )

  lifecycle {
    # Due to issue [#3116 Cannot use interpolations in lifecycle attributes](https://github.com/hashicorp/terraform/issues/3116)
    # a variable cannot be used to configure `ignore_changes`
    # for the `lifecycle`attribute.
    # A `for` statement produces the following error message:
    # `A static list expression is required.`
    # => only a hard coded list of attributes is possible
    ignore_changes = [
      ami,
      user_data,
    ]
  }
}
