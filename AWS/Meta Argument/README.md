# What is meta argument?

A meta-argument in Terraform is a special argument that controls how resources are created, updated, or destroyed. Meta-arguments are not specific to any particular resource type, and can be used to configure behavior across all resources in a Terraform configuration.

# What can we control?

we can control- to some extent - the lifecycle further than the three above stages for our resources. Terraform gives us the following options that we can use in the lifecycle meta-argument:

**create_before_destroy**
 when an in-place update has to occur Terraform will create the new instance prior to destroying the old.

**prevent_destory**
 do not allow the destroy flow to actually destruct the resource.

**ignore_changes**
ignore any changes on specified fields or an entire object

## Create Before Destroy

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

## Prevent Destroy

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

## Ignore Changes

Now we come to one of the more commonly used and in my opinion the most dangerous, ignore_changes. A reason why you might want to use ignore_changes is if some outside force / process is going to be modifying your resources, an example of this might be mutation of tags or tag values via Azure policy or potentially the number of instances of a resource due to a scaling event. Both of those examples are what I would consider good reasons to utilise ignore_changes. Lets look at a very basic example.

```bash
resource "scratch_block" "this" {
  in {
    string = "Meow"
    number = 42
    bool = true
  }

  lifecycle {
    ignore_changes = [
      in
    ]
  }
}
```

In the above scratch_block we are ignoring any changes to the in block, and we cannot ignore a specific property on that block as the block is actually represented as a set which does not have an index or referenceable value. It is important to note that the values provided here must be static, you cannot pass in a variable or a splat. The only exception is the use of the special all keyword in place of a list which will then ignore all attributes on the resource.

ignore_changes becomes dangerous when you start ignoring entire resources as then changes you make to the code won’t alter the resource this means you’re only managing two stages of the resource Apply and Destroy all alteration would then have to be managed by an external system.

Many organisations uses tags for managing or attributing cost with cloud resources so ignore changing to particular tags or the tags property can be very valuable as it allows an external system to manage the tags on resources for you without Terraform overwriting the changes. When using ignore_changes my advice to be as specific about the property you’re wanting to ignore as you possibly can be!