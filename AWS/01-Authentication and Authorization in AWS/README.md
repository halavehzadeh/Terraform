
# Authenticating to AWS with Terraform
There are many ways to authenticate using the Terraform AWS provider. Configuration for the AWS Provider can be derived from several sources, which are applied in the following order:

1-Parameters in the provider configuration
2-Environment variables
3-Shared credentials and configuration files
4-Container credentials
5-Instance profile credentials and region
6-External credentials proces

Before we can authenticate, we will need to create an access key for use with Terraform. To do so, browse to the IAM section in the AWS console and click on the user, and go to security crenditial tab

![alter text](/home/andrew/Pictures/Screenshots/Screenshot from 2024-11-04 09-49-24.png)