data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/hvm-ssd/ubuntu-focal-20.04-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_vpc" "default" {
  default = true
}
resource "aws_instance" "web" {
  ami              = data.aws_ami.ubuntu.id
  instance_type    = "var.instance_type"

  vpc_security_group_ids = [module.blog_sg.security_group_id]

  tags = { Name = "HelloWorld" }
}

module "blog_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"
  name = "blog"

  vpc_id = data.aws_vpc.default.id

  ingress_rules       = ["http-80-tcp", "http-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}