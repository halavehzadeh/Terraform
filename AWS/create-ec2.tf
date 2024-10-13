provider "aws" {
  region     = "us-east-1"
}
resource "aws_instance" "myec2" {
  ami = "ami-00c39f71452c08778"
  instance_type = "t2.micro"
}

resource "aws_instance" "web1" {
  ami = "ami-123"
  instance_type = "t3.micro"
}

