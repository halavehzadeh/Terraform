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


    ```bash
    #Configure the AWS Provider
    provider "aws" {
       region = "us-east-1"
      }

     # Create an IAM user
   resource "aws_iam_user" "user" {
   name = var.user_name
   }
    ```

3. **Initialize Terraform:** 
   Run the following command to initialize your Terraform workspace and download necessary providers:

   ```bash

    terraform init

4. **Apply the configuration**
   Run the following command to create the user. You will be prompted to provide the user_name variable value:
   ```bash
   terraform apply
   ```
   After reviewing the plan, type yes to create the user.
5. **View the Output:** 
   After Terraform completes, it will display the access key and secret key for the new user. Make sure to store the secret key securely, as it won't be retrievable after this.

