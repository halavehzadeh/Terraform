# What is a Terraform provisioner?
Terraform provisioners have nothing in common with providers, they allow the execution of various commands or scripts on either local or remote machines, and they can also transfer files from a local environment to a remote one. There are three available provisioners: file (used for copying), local-exec (used for local operations), remote-exec (used for remote operations). The file and remote-exec provisioners need a connection block to be able to do the remote operations.

Provisioning mainly deals with configuration activities that happen after the resource is created. It may involve some file operations, executing CLI commands, or even executing the script. Once the resource is successfully initialized, it is ready to accept connections. These connections help Terraform log into the newly created instance and perform these operations.

## Terraform provisioners types
There are three types of provisioners in Terraform: 

**Local-exec provisioners**
**Remote-exec provisioners**
**File provisioners**

## Terraform local-exec provisioner
The local-exec provisioner works on the Terraform host – where Terraform configuration is applied/executed. It is used to execute any shell command. It is used to set or read environment variables, details about the resource created, invoke any process or application, etc.

If we ship any shell script along with the Terraform config, or if the shell scripts are already available on the host to be invoked, local-exec provisioners are used to execute the same.

In the example below, we create an EC2 instance in AWS. It uses a local-exec provisioner to save the private_ip address of the instance created in a text file. This provisioner executes in the same working directory where terraform apply is run once the provisioning is successful.

```bash
resource "aws_instance" "my_vm" {
 ami           = var.ami //Amazon Linux AMI
 instance_type = var.instance_type
 
 provisioner "local-exec" {
   command = "echo ${self.private_ip} >> private_ip.txt"
 }
 
 tags = {
   Name = var.name_tag,
 }
}
```
## Terraform remote-exec provisioner
The remote-exec provisioners are similar to local-exec provisioners – where the commands are executed on the target EC2 instance instead of Terraform host. This is accomplished by using the same connection block that is used by the file provisioned. We use a remote-exec provisioner to run a single command or multiple commands.
The example below performs a simple task on the EC2 instance that is created by Terraform. Once the EC2 instance creation is successful, Terraform’s remote-exec provisioner logs in to the instance via SSH and executes the commands specified in the inline attribute array.

```bash
resource "aws_instance" "my_vm" {
 ami           = var.ami //Amazon Linux AMI
 instance_type = var.instance_type
 
 key_name        = "tfsn"
 security_groups = [aws_security_group.http_access.name]
 
 provisioner "remote-exec" {
   inline = [
     "touch hello.txt",
     "echo 'Have a great day!' >> hello.txt"
   ]
 }
 
 connection {
   type        = "ssh"
   host        = self.public_ip
   user        = "ec2-user"
   private_key = file("./tfsn.cer")
   timeout     = "4m"
 }
 
 tags = {
   Name = var.name_tag,
 }
}
```