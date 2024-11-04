provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "myec2" {
  ami                    = "ami-00c39f71452c08778"
  instance_type          = "t2.micro"
  key_name               = "terraform-key"
  vpc_security_group_ids = ["sg-06d5c3cf797f5c335"]
  tags = {
    Name = "Terraform"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/home/andrew/Documents/Terraform-tets/terraform-key.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install nginx",
      "sudo systemctl start nginx",
    ]
  }
}