provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "lb" {
  name = "provisioner-user"

  provisioner "local-exec" {
    command = "echo This is creation time provisioner"
  }

  provisioner "local-exec" {
    command = "echo This is destroy time provisioner"
    when    =  destroy
  }
}