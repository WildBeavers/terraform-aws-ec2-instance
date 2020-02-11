provider "aws" {
  region = "eu-west-1"
}

##################################################################
# Data sources to get VPC, subnet, security group and AMI details
##################################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "example"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}

resource "aws_eip" "this" {
  vpc      = true
  instance = module.ec2.id[0]
}

module "ec2" {
  source = "../../"

  //  private_ips                 = ["172.31.32.5", "172.31.46.20"]
  ami           = data.aws_ami.amazon_linux.id
  associate_public_ip_address = true
  instance_count              = 2
  instance_type               = "t3.nano"
  name                        = "example-normal"
  subnet_id                   = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids      = [module.security_group.this_security_group_id]

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 10
    },
  ]

  tags = {
    "Env"      = "Private"
    "Location" = "Secret"
  }
}

module "ec2_with_t2_unlimited" {
  source = "../../"

  //  private_ip = "172.31.32.10"
  ami                         = data.aws_ami.amazon_linux.id
  associate_public_ip_address = true
  cpu_credits                 = "unlimited"
  instance_count              = 1
  instance_type               = "t2.micro"
  name                        = "example-t2-unlimited"
  subnet_id                   = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids      = [module.security_group.this_security_group_id]
}

module "ec2_with_t3_unlimited" {
  source = "../../"

  ami                         = data.aws_ami.amazon_linux.id
  associate_public_ip_address = true
  cpu_credits                 = "unlimited"
  instance_count              = 1
  instance_type               = "t3.large"
  name                        = "example-t3-unlimited"
  subnet_id                   = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids      = [module.security_group.this_security_group_id]
}

# This instance won't be created
module "ec2_zero" {
  source = "../../"

  ami                    = data.aws_ami.amazon_linux.id
  instance_count         = 0
  instance_type          = "c5.large"
  name                   = "example-zero"
  subnet_id              = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids = [module.security_group.this_security_group_id]
}
