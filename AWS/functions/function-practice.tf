

variable "region" {
  type        = string
  default     = "ca-central-1"
  description = "Define region to create resource"
}


variable tags {
  type        = list
  default     = ["firstec2","secondec2"]
  description = "Name of instance"
}

variable "ami" {
  type        = map
  default     = {
    "us-east-1" = "ami-08a0d1e16fc3f61ea"
    "us-west-2" = "ami-0b20a6f09484773af"
    "ca-central-1" = "ami-049332278e728bdb7"
  }
  description = "ami code in each region"
}

provider "aws" {
  region = var.region
}
resource "aws_instance" "app-dev" {
  ami = lookup(var.ami,var.region)
  instance_type = "t2.micro"
  count = length(var.tags)
  
  tags = {
    Name = element(var.tags,count.index)
    CreationDate = formatdate("DD MMM YYYY hh:mm ZZZ",timestamp())
  }

}
