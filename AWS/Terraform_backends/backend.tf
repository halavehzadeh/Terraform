terraform {
  backend "s3" {
    bucket = "terraform-backend-bucket-2024"
    key = "udemy/terraform.tfstate"
    region = "us-east-1"
    
  }
}