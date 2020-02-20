
output "instances" {
  description = <<EOF
    List of EC2 Instance Objects (see [aws_instance](https://www.terraform.io/docs/providers/aws/r/instance.html)
    for all available attributes)
  EOF

  value = module.ec2.instances
}

output "a_records" {
  description = <<EOF
    List of Route53 A records.
  EOF

  value = module.ec2.a_records
}
