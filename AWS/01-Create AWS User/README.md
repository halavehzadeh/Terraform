# Create AWS IAM User with Terraform

This guide provides a step-by-step process for creating an IAM user in AWS using Terraform. This setup includes basic user information, access key generation, and attaching policies as needed.

## Prerequisites

1. **Terraform**: Make sure Terraform is installed on your system. You can download it from [Terraform's official website](https://www.terraform.io/downloads).
2. **AWS CLI**: Ensure the AWS CLI is configured with appropriate permissions to create IAM users. Check the [AWS CLI installation guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) for setup instructions.
3. **AWS Account**: You need an AWS account with permissions to create IAM users and assign policies.

## Usage

1. **Clone the Repository** (optional):
   ```bash
   git clone https://github.com/yourusername/your-repository.git
   cd your-repository

2. Set up Terraform Configuration File:

Create a file named main.tf and add the following code. This code defines an IAM user in AWS, generates an access key, and attaches a specified policy.

2. **Configure the AWS Provider**
    ```bash
provider "aws" {
  region = "us-east-1"
}

# Define variables
variable "user_name" {
  description = "Name of the IAM user to create"
  type        = string
}

variable "policy_arn" {
  description = "ARN of the policy to attach to the user"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# Create an IAM user
resource "aws_iam_user" "user" {
  name = var.user_name
}

# Create an access key for the user
resource "aws_iam_access_key" "user_key" {
  user = aws_iam_user.user.name
}

# Attach a policy to the user
resource "aws_iam_user_policy_attachment" "user_policy" {
  user       = aws_iam_user.user.name
  policy_arn = var.policy_arn
}

# Output the access key and secret key
output "access_key" {
  value = aws_iam_access_key.user_key.id
}

output "secret_key" {
  value     = aws_iam_access_key.user_key.secret
  sensitive = true
}
