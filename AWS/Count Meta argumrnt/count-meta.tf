provider "aws" {
  region     = "us-east-1"
}
resource "aws_instance" "myec2" {
  ami = "ami-00c39f71452c08778"
  instance_type = "t2.micro"
  #here you can define how many instacne you want to create 
  count = 2
  tags = {
    Name = "Payment-system-${count.index}"
  }
}


resource "aws_iam_user" "test" {
  name = "prod-user-${count.index}"
  count = 3
  }


variable "users" {
  type        = list
  default     = ["alice", "bob", "johnc"]
}

  resource "aws_iam_user" "test" {
  name = var.users[count.index]
  count = 3
  }