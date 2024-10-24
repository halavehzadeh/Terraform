provider "aws" {
  region     = "us-east-1"
}


data "aws_ami" "myimage" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.myimage.image_id
  instance_type = "t2.micro"

}