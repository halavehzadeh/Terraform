provider "aws" {
  region     = "us-east-1"
}


variable "environment" {
  default     = "prodcution"
}

variable "region" {
  default     = "us-east-1"
}  
resource "aws_instance" "myec2" {
  ami = "ami-00c39f71452c08778"
  instance_type = var.environment == "prodcution"  && var.region == "us-east-1" ? "m5.large" : "m2.micro"

}