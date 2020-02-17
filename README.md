# AWS EC2 Instance Terraform module

Terraform module which creates EC2 instance(s) on AWS.

These types of resources are supported:

* [EC2 instance](https://www.terraform.io/docs/providers/aws/r/instance.html)
* (optional) [EBS volume](https://www.terraform.io/docs/providers/aws/r/ebs_volume.html)
* (optional) [Route53 record](https://www.terraform.io/docs/providers/aws/r/route53_record.html)
  (A record)

## Terraform versions

Only Terraform version 0.12.6 or later is supported, there are no plans
to backport features for Terraform 0.11. Pin module version to `~> v3.0`.

## Usage

```hcl
module "ec2_cluster" {
  source                 = "github.com/WildBeavers/terraform-aws-ec2-instance.git?ref=master"

  ami                    = "ami-ebd02392"
  instance_count         = 5
  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  name                   = "my-cluster"
  subnet_id              = "subnet-eddcdzz4"
  vpc_security_group_ids = ["sg-12345678"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Examples

* [Basic EC2 instance](https://github.com/terraform-aws-modules/terraform-aws-ec2-instance/tree/master/examples/basic)
* [EC2 instance with EBS volume attachment](https://github.com/terraform-aws-modules/terraform-aws-ec2-instance/tree/master/examples/volume-attachment)

## Modul Documentation

For both, [input](docs/user/variables.md) and [output](docs/user/outputs.md) 
parameters, documentation is available.

## Notes

* When using variable `attached_block_device` then you **MUST NOT** use
  `ebs_block_device` of the EC2 module. Terraform currently supports only
  either inline (i.e. as a sub block of `aws_instance`) or separate
  creation and attachment of EBS volumes
  (see [note](https://www.terraform.io/docs/providers/aws/r/instance.html#block-devices))
  The `attached_block_device` is the preferred way for creating volumes
  using this module.

## Authors

This module is a fork of the module [terraform-aws-ec2-instance](https://github.com/terraform-aws-modules/terraform-aws-ec2-instance)
which has been developed by [Anton Babenko](https://github.com/antonbabenko).

## License

Apache 2 Licensed. See LICENSE for full details.
