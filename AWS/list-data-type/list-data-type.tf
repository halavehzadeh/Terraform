
provider "aws" {
  region     = "us-east-1"
}


variable "my-list" {
  type = list
}
output "varibale_value" {
  value       = var.my-list
}

