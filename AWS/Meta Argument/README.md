# What is meta Argument?

A meta-argument in Terraform is a special argument that controls how resources are created, updated, or destroyed. Meta-arguments are not specific to any particular resource type, and can be used to configure behavior across all resources in a Terraform configuration.

** What can we control?

we can control- to some extent - the lifecycle further than the three above stages for our resources. Terraform gives us the following options that we can use in the lifecycle meta-argument:

**create_before_destroy**
 when an in-place update has to occur Terraform will create the new instance prior to destroying the old.

**prevent_destory**
 do not allow the destroy flow to actually destruct the resource.

# Create Before Destroy

The create_before_destroy option is extremely useful in cases where the new instance of the resource must be there before destroy the old one. For example perhaps a public IP needs to be recreated but you don’t want the service to be inaccessible so you would ensure that the new address is created prior to the old one being destroyed.

```bashe
resource "scratch_string" "this" {
  in = "create_before_destroy"

  lifecycle {
    create_before_destroy = true
  }
}
```
The above will now ensure that in the event this resource is required to be replaced in- place that it will create the new instance first.

# Prevent Destroy

prevent_destroy is another bool option which we can switch on, we would use this to ensure that Terraform never destroys the particular resource. On destroy the resource would be removed from state but still exist in the real world. This is useful in scenarios where perhaps not all your resources are managed by Terraform, or you do not want anyone to accidentally delete a particular resource.

Let’s dive into an example to better understand this concept.

```bashe
resource "azurerm_resource_group" "this" {
  name     = "rg-prod"
  location = "australiasoutheast"

  lifecycle {
    prevent_destroy = true
  }
}
```

In the above we are creating a resource group, and we have informed Terraform we want to prevent its destruction through the lifecycle meta-argument. In this scenario let’s assume that we are only managing a portion of the resources within the resource group (RG) via Terraform and other via some other mechanism. If we were to not have prevent_destroy when we eventually did a destruction those resources created out of Terraform would also be destroyed. By having prevent_destroy we are now required to be more assertive when we want to destroy the RG, we would either have to remove it manually or commit a change removing the lifecycle attribute.

I find that prevent_destroy is a favourite to security folks as it helps to add an extra level of assurance around destructive operations, especially on resource types that have such a large blast area like a resource group.
