# iterate first over the instances and then over the attached EBS volumes
# => it is possible to increase and decrease the number of instances
# => it is not possible do add/remove additional volumes for all instances
resource "aws_ebs_volume" "this" {
  count = local.attached_block_device_total

  availability_zone = data.aws_subnet.this[
    floor(count.index / local.attached_block_device_count) % length(var.subnet_ids)
  ].availability_zone

  encrypted = lookup(var.attached_block_device[
    count.index % local.attached_block_device_count
  ], "encrypted", null)

  iops = lookup(var.attached_block_device[
    count.index % local.attached_block_device_count
  ], "iops", null)

  kms_key_id = lookup(var.attached_block_device[
    count.index % local.attached_block_device_count

  ], "kms_key_id", null)

  size = lookup(var.attached_block_device[
    count.index % local.attached_block_device_count

  ], "volume_size", null)

  snapshot_id = lookup(var.attached_block_device[
    count.index % local.attached_block_device_count

  ], "snapshot_id", null)

  type = lookup(var.attached_block_device[
    count.index % local.attached_block_device_count
  ], "volume_type", null)

  tags = merge(
    {
      Name = "${local.hostnames[floor(count.index / local.attached_block_device_count)]}${lookup(var.attached_block_device[
        count.index % local.attached_block_device_count
      ], "volume_tag_name_suffix", "")}"
    },
    var.volume_tags,
  )
}

resource "aws_volume_attachment" "this" {
  count = local.attached_block_device_total

  device_name = lookup(var.attached_block_device[
    count.index % local.attached_block_device_count
  ], "device_name", null)
  instance_id = aws_instance.this[
    floor(count.index / local.attached_block_device_count)
  ].id
  volume_id = aws_ebs_volume.this[count.index].id
}
