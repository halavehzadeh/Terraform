
provider "aws" {
  region     = "us-east-1"
}


variable "username" {
  type        = number
  description = "description"
}


resource "aws_iam_user" "lb" {
  name = var.username
}

resource "aws_instance" "web" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["sg-06dc77ed59c310f03"]
}