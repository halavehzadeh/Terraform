# What is Terraform Workspace?
Terraform workspaces enable us to manage multiple deployments of the same configuration. When we create cloud resources using the Terraform configuration language, the resources are created in the default workspace. It is a very handy tool that lets us test configurations by giving us flexibility in resource allocation, regional deployments, multi-account deployments, and so on.

## How to use Terraform workspace command?
To begin, let’s look at the options available to us in the help:

```bash
terraform worksapce --help
```
The options are quite straightforward here. We can use the workspace command to list all the available workspaces and show the currently selected one. We can also create new workspaces and delete old ones. Finally, to navigate through workspaces, we use the select command.

## Run terraform workspace show
To check the current workspace we are in, run the command below.

```bash
terraform workspace show
```
The output here shows that we are currently in the workspace named default.

## Run terraform workspace list

The list command lists all the currently created workspaces, including the default workspace. The start mark beside the default workspace indicates the currently selected workspace we are in.

```bash
terraform workspace list
```
## Create a new workspace

Let us create another workspace and select the same. We can do this by running the new command with the desired name of the new workspace as below.

```bash
terraform workspace new test_workspace
```

## Verify the setup

We can verify this selection is made by running the show command as below.

```bash
terraform workspace show
```
## How to delete a Terraform workspace
To delete the workspace, first select a different workspace. In our case, we go back to the default workspace and run the delete command. Terraform does not let us delete the currently selected workspace

```bash
terraform workspace select default

terraform workspace delete test_workspcae
```

