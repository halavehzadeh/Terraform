
# How to create multiple resources using "for_each"

To understand better what purpose for_each serves, let’s see how you could achieve the same outcome in Terraform without using for_each.

The outcome we’re talking about is deploying multiple copies of the same resource. So, let’s take virtual machines, for example.

Normally, to deploy more than one virtual machine, you’d have to specify multiple resource blocks, like this:

```bash
resource "google_compute_instance" "vm1" {
 name         = "vm1"
 machine_type = "e2-small"
 zone         = "us-central1-a"
 (...)
}
 
resource "google_compute_instance" "vm2" {
 name         = "vm2"
 machine_type = "e2-medium"
 zone         = "us-central1-a"
 (...)
}
 
resource "google_compute_instance" "vm3" {
 name         = "vm3"
 machine_type = "f1-micro"
 zone         = "us-central1-a"
 (...)
}
```
Seems like a lot of duplicated code, doesn’t it? That’s exactly where for_each can help.

Instead of duplicating all that code for each virtual machine, you can define your resource once and provide a map or a set of strings to iterate over.

Take a look at the example. This is how achieving the same results as above would look with for_each:

```bash

resource "google_compute_instance" "vm" {
 
for_each = {
 
"vm1" = "e2-small"
 
"vm2" = "e2-medium"
 
"vm3" = "f1-micro"
 
}
 
name = each.key
 
machine_type = each.value
 
zone = "us-central1-a"
 
(...)
 
}

```

As you can see, we defined the configuration parameters that differ per virtual machine as key-value pairs in the for_each block and left the parameters that are the same for each VM in the resource block. Then, we accessed the key-value pair by special keywords each.key and each.value.

What if you want to pass more than just two (key and value) parameters? For example, what if you want to also parameterize the zone in the above example? You can simply change the value to a map, as follows:

```bash
resource "google_compute_instance" "vm" {
 
for_each = {
 
"vm1" = { vm_size = "e2-small", zone = "us-central1-a" }
 
"vm2" = { vm_size = "e2-medium", zone = "us-central1-b" }
 
"vm3" = { vm_size = "f1-micro", zone = "us-central1-c" }
 
}
 
name = each.key
 
machine_type = each.value.vm_size
 
zone = each.value.zone
 
(...)
 
}
```
You can pass as many parameters in the value as you want. Then in the actual resource configuration, you can reference them with each.value.<parameter_key>.

To keep your code clean and have the ability to reuse values for different resources, you can even extract the actual parameters into a variable:

```bash
locals {
 virtual_machines = {
   "vm1" = { vm_size = "e2-small", zone = "us-central1-a" },
   "vm2" = { vm_size = "e2-medium", zone = "us-central1-b" },
   "vm3" = { vm_size = "f1-micro", zone = "us-central1-c" }
 }
}
 
resource "google_compute_instance" "vm" {
 for_each = local.virtual_machines
 name = each.key
 machine_type = each.value.vm_size
 zone = each.value.zone
 (...)
}
```
