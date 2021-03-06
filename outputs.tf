/*  #########################################################################
    Output variables of the module
    ######################################################################### */

output "instances" {
  description = <<EOF
List of EC2 instance objects (see [aws_instance](https://www.terraform.io/docs/providers/aws/r/instance.html)
for all available attributes)
  EOF

  value = aws_instance.this.*
}

output "a_records" {
  description = <<EOF
List of Route53 A records (see [aws_route53_record](https://www.terraform.io/docs/providers/aws/r/route53_record.html)
for all available attributes)).
  EOF

  value = aws_route53_record.a.*
}
