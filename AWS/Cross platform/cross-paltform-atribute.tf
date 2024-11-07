
provider "aws" {
  region     = "us-east-1"
}

resource "aws_eip" "lb" {
  domain   = "vpc"
}


resource "aws_security_group" "allow_tls" {
  name        = "terraform-firewall"
  description = "Manage from Terraform"
}



resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "${aws_eip.lb.public_ip}/32" #IP address was taken from resurce "aws_eip"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
