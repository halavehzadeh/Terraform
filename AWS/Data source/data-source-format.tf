provider "aws" {
  region     = "us-east-1"
}

data "aws_instances" "example" {
  filter {
        name   = "tag:Team"
        values = ["Prodcution"]
  }

 }