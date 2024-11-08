# What are backends in Terraform?
Backends in Terraform are responsible for managing the storage and state of infrastructure deployments. They define where and how Terraform’s state data is stored, how it can be accessed, and who can access it, ensuring the state is preserved across multiple runs. Common backend types include local and remote services (such as AWS S3, GCP Cloud Storage, and Azure Blob Storage).

The core feature of Terraform backends is the ability to safely store your state file so Terraform knows which changes have been applied already and which will be applied when you need to run your code again.
ome supported backend types:

1-Local Storage — The default backend for Terraform, where the state file is stored and managed in the local machine that runs Terraform
2-AWS S3 Bucket — The state file is stored and managed in an AWS S3 bucket.
3-Azure Blob Storage — The state file is stored and managed in Azure Blob Storage.
4-Google Cloud Storage bucket — The state file is stored and managed in a Google Cloud Storage bucket.

## File configuration

You can specify the backend configuration variables in a file named using the recommended pattern *.{BACKEND}.tfbackend (e.g., configuration.s3.tfbackend) and pass this file during Terraform initialization. 

Note: Although Terraform documentation suggests this pattern to clarify your file’s purpose, it is not enforced but is the recommended naming convention. 

Then set the variables in the file:

###  AWS S3 bucket backend configuration


```bash
terraform {
  backend "s3" {
    bucket          = “MY_BUCKET”
    key               = “PATH/TO/KEY”
    region           = “MY_REGION”
  }
}

