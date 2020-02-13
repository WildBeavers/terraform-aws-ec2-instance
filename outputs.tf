/*  #########################################################################

    ######################################################################### */

output "instances" {
  description = <<EOF
    List of EC2 Instance Objects (see [aws_instance](https://www.terraform.io/docs/providers/aws/r/instance.html)
    for all available attributes)
  EOF

  value = aws_instance.this.*
}

output "a_record" {
  description = <<EOF
    List of Route53 A records.
  EOF

  value = aws_route53_record.a.*
}
