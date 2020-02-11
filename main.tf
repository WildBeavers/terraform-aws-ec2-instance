locals {
  hostnames                   = var.instance_count > 1 || var.use_num_suffix ? formatlist(var.hostname_formatstring, var.name, range(1, var.instance_count + 1)) : [var.name]
  is_t_instance_type          = replace(var.instance_type, "/^t[23]{1}\\..*$/", "1") == "1" ? true : false
  attached_block_device_count = length(var.attached_block_device)
  attached_block_device_total = var.instance_count * local.attached_block_device_count
  subnet_ids                  = coalescelist(var.subnet_ids, [var.subnet_id])
}

/*  =========================================================================
    Using subnets to determine the az instead of using calculated
    az information from aws_instance.
    This is necessary in order to prevent that the attached EBS volumes
    are destroyed when an EC2 instance is recreated.
    ========================================================================= */
data "aws_subnet" "this" {
  count = length(local.subnet_ids)

  id = local.subnet_ids[count.index]
}

data "template_file" "user_data" {
  count = var.instance_count

  template = var.user_data

  vars = {
    hostname = local.hostnames[count.index]
  }
}
