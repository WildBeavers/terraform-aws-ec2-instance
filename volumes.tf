
resource "aws_ebs_volume" "this" {
  for_each = {
    for instance_volume in local.attached_instance_block_device :
    "${instance_volume.hostname}.${instance_volume.volume_name}" => instance_volume
  }

  availability_zone = each.value.availability_zone
  encrypted         = each.value.encrypted
  iops              = each.value.iops
  kms_key_id        = each.value.kms_key_id
  size              = each.value.volume_size
  snapshot_id       = each.value.snapshot_id
  type              = each.value.volume_type

  tags = merge(
    {
      Name = each.value.hostname
    },
    var.volume_tags,
  )
}

resource "aws_volume_attachment" "this" {
  for_each = {
    for instance_volume in local.attached_instance_block_device :
    "${instance_volume.hostname}.${instance_volume.volume_name}" => instance_volume
  }

  device_name = each.value.device_name
  instance_id = aws_instance.this[each.value.instance_id].id
  volume_id   = aws_ebs_volume.this[each.key].id
}
