provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "myec2" {
  ami = "ami-00c39f71452c08778"
  instance_type = var.list[2]
}

variable "list" {
    type = list
    default = ["m5.large","m5.xlarge","t2.meduim"]
}