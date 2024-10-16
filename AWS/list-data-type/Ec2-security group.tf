provider "aws" {
  region     = "us-east-1"
}
resource "aws_instance" "myec2" {
  ami = "ami-00c39f71452c08778"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-0e016f8b10fdc7307 ","sg-0b2163fd32f6e5c3d"]
}