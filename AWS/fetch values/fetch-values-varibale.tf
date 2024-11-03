
provider "aws" {
  region     = "us-east-1"
}

variable "types" {
    type = map
    default = {
        us-east-1 = "t.2.micro"
        us-west-2 = "t2.nano"
        ap-south-1 ="t2.small"
    }
}


resource "aws_instance" "myec2" {
  ami = "ami-00c39f71452c08778"
  instance_type = var.types["us-west-2"]
}