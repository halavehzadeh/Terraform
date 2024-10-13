provider "aws" {
    region = "us-east-1" 
}
resource "aws_eip" "lb" {
  domain   = "vpc"
}

#show ip address in screen 
output "public-ip" {
    value = aws_eip.lb.public_ip
}

#if you want to see all attribute in screen

output "public-ip" {
    value = aws_eip.lb
}