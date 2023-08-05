data "aws_ami" "app_ami" {
  most_recent = true
  }
  
resource "aws_instance" "web" {
  ami           = ami-0b594cc165f9cddaa
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
    Department = "Engineering"
  }
}
