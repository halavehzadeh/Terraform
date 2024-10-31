
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

}

variable "sg_ports" {
  type        = list(number)
  description = "List of ingress ports"
  default     = [22, 80, 443, ]
}

resource "aws_security_group" "dynamicsg" {
  name        = "Dynamic Security Group"
  description = "Allow all inbound and outbound traffic"

  dynamic "ingress" {
    for_each = var.sg_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
     for_each = var.sg_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
    
  }