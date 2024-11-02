terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.74.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}




resource "aws_iam_user" "demouser" {
  name = "trafform-test1"
}

