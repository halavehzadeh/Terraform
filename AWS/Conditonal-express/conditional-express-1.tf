provider "aws" {
  region     = "us-east-1"
}


variable "environment" {
  default     = "production"
}

  
resource "aws_instance" "myec2" {
  ami = "ami-00c39f71452c08778"
  instance_type = var.environment == "development" ? "t2.micro" : "m5.large"

}