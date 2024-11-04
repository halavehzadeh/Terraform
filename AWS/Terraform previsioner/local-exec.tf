provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "myec2" {
  ami           = "ami-00c39f71452c08778"
  instance_type = "t2.micro"
  tags = {
    Name = "Terraform-baseball"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> server_ip.txt"
  }

}
