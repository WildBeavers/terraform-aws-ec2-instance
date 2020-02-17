/*  #########################################################################
    Create A record(s) with the private IP adress of the EC2 instance(s)
    ######################################################################### */

resource "aws_route53_record" "a" {
  count = var.instance_private_dns_record == null ? 0 : var.instance_count

  name    = "${local.hostnames[count.index]}.${var.instance_private_dns_record.domain}"
  records = [aws_instance.this[count.index].private_ip]
  ttl     = var.instance_private_dns_record.ttl
  type    = "A"
  zone_id = var.instance_private_dns_record.hosted_zone_id
}
