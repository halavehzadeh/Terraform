variable "my-set" {
    type = set(string)
    default = ["alice","bob","john"]
}

output "myset" {
    value = var.my-set
}