resource "aws_route53_record" "a" {
  count = lookup(var.instance_private_dns_record, "domain", null) != null && lookup(var.instance_private_dns_record, "hosted_zone_id", null) != null && lookup(var.instance_private_dns_record, "ttl", null) != null ? var.instance_count : 0

  name    = "${local.hostnames[count.index]}.${var.instance_private_dns_record.domain}"
  records = [aws_instance.this[count.index].private_ip]
  ttl     = var.instance_private_dns_record.ttl
  type    = "A"
  zone_id = var.instance_private_dns_record.hosted_zone_id
}
