provider "aws" {
  region = "eu-west-1"
}

data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "ena-support"
    values = ["true"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_availability_zones" "this" {}

locals {
  vpc_cidr = "10.0.0.0/16"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.18.0"

  azs                  = data.aws_availability_zones.this.names.*
  cidr                 = local.vpc_cidr
  enable_dhcp_options  = true
  enable_dns_hostnames = true
  enable_nat_gateway   = true
  name                 = "ec2-test-vpc"
  single_nat_gateway   = true

  private_subnets = [
    cidrsubnet(local.vpc_cidr, 8, 128),
    cidrsubnet(local.vpc_cidr, 8, 129),
    cidrsubnet(local.vpc_cidr, 8, 130),
  ]
  public_subnets = [
    cidrsubnet(local.vpc_cidr, 8, 0),
    cidrsubnet(local.vpc_cidr, 8, 1),
    cidrsubnet(local.vpc_cidr, 8, 2),
  ]
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  description         = "Security group for example usage with EC2 instance"
  egress_rules        = ["all-all"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp"]
  name                = "example"
  vpc_id              = module.vpc.vpc_id
}

module "ec2" {
  source = "../../"

  ami                         = data.aws_ami.amazon_linux2.id
  associate_public_ip_address = true
  instance_count              = 2
  instance_type               = "t3.nano"
  name                        = "example-normal"
  subnet_ids                  = module.vpc.private_subnets
  vpc_security_group_ids      = [module.security_group.this_security_group_id]

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 8
    },
  ]

  attached_block_device = [
    {
      device_name = "/dev/sdf"
      volume_name = "docker"
      volume_size = "8"
      volume_type = "standard"
    },
    {
      device_name = "/dev/sdg"
      volume_name = "data"
      volume_size = "16"
      volume_type = "standard"
    }
  ]

  tags = {
    "Env"      = "Private"
    "Location" = "Secret"
  }
}

/*
module "ec2_with_t2_unlimited" {
  source = "../../"

  ami                         = data.aws_ami.amazon_linux2.id
  associate_public_ip_address = true
  cpu_credits                 = "unlimited"
  instance_count              = 1
  instance_type               = "t3.nano"
  name                        = "example-t3-unlimited"
  subnet_ids                  = module.vpc.private_subnets
  vpc_security_group_ids      = [module.security_group.this_security_group_id]
}
*/
