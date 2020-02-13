locals {
  attached_block_device_count = length(var.attached_block_device)
  attached_block_device_total = var.instance_count * local.attached_block_device_count
  attached_instance_block_device = [
    for pair in setproduct(local.hostname_map, var.attached_block_device) :
    {
      availability_zone = data.aws_subnet.this[pair[0].index % length(var.subnet_ids)].availability_zone
      device_name       = pair[1].device_name
      encrypted         = lookup(pair[1], "encrypted", null)
      hostname          = pair[0].hostname
      instance_id       = pair[0].index
      iops              = lookup(pair[1], "iops", null)
      kms_key_id        = lookup(pair[1], "kms_key_id", null)
      snapshot_id       = lookup(pair[1], "snapshot_id", null)
      volume_name       = pair[1].volume_name
      volume_size       = lookup(pair[1], "volume_size", null)
      volume_type       = lookup(pair[1], "volume_type", null)
    }
  ]
  hostnames = var.instance_count > 1 || var.use_num_suffix ? formatlist(var.hostname_formatstring, var.name, range(1, var.instance_count + 1)) : [var.name]
  hostname_map = [
    for index, element in local.hostnames :
    {
      hostname = element
      index    = index
    }
  ]
  is_t_instance_type = replace(var.instance_type, "/^t[23]{1}\\..*$/", "1") == "1" ? true : false
}

/*  =========================================================================
    Using subnets to determine the az instead of using calculated
    az information from aws_instance.
    This is necessary in order to prevent that the attached EBS volumes
    are destroyed when an EC2 instance is recreated.
    ========================================================================= */
data "aws_subnet" "this" {
  count = length(var.subnet_ids)

  id = var.subnet_ids[count.index]
}

data "template_file" "user_data" {
  count = var.instance_count

  template = var.user_data

  vars = {
    hostname = local.hostnames[count.index]
  }
}
