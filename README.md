# AWS EC2 Instance Terraform module

Terraform module which creates EC2 instance(s) on AWS.

These types of resources are supported:

* [EC2 instance](https://www.terraform.io/docs/providers/aws/r/instance.html)
* (optional) [EBS volume](https://www.terraform.io/docs/providers/aws/r/ebs_volume.html)
* (optional) [Route53 record](https://www.terraform.io/docs/providers/aws/r/route53_record.html)
  (A record)

## Terraform versions

Only Terraform version 0.12 is supported, there are no plans
to backport features for Terraform 0.11. Pin module version to `~> v2.0`.

## Usage

```hcl
module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "my-cluster"
  instance_count         = 5

  ami                    = "ami-ebd02392"
  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = "subnet-eddcdzz4"

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

* `network_interface` can't be specified together with
  `associate_public_ip_address`, which makes `network_interface`
  not configurable using this module at the moment
* Changes in `ebs_block_device` argument will be ignored. 
  Use [aws_volume_attachment](https://www.terraform.io/docs/providers/aws/r/volume_attachment.html)
  resource to attach and detach volumes from AWS EC2 instances.
  See [this example](https://github.com/terraform-aws-modules/terraform-aws-ec2-instance/tree/master/examples/volume-attachment)
  or use the parameter `attached_block_device`.
* When using variable `attached_block_device` then you **MUST NOT** use
  `ebs_block_device` of the EC2 module. Terraform currently supports only
  either inline (i.e. as sub block of `aws_instance`) or separate
  creation and attachment of EBS volumes
  (see [note](https://www.terraform.io/docs/providers/aws/r/instance.html#block-devices))
* One of `subnet_id` or `subnet_ids` is required. If both are provided,
  the value of `subnet_id` is prepended to the value of `subnet_ids`.

## Authors

This module is a fork of the module [terraform-aws-ec2-instance](https://github.com/terraform-aws-modules/terraform-aws-ec2-instance)
which has been developed by [Anton Babenko](https://github.com/antonbabenko).

## License

Apache 2 Licensed. See LICENSE for full details.
