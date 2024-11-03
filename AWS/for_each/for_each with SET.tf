variable "user_names" {
    type = set(string)
    default = ["alice","bob","john","james"]
}

resource "aws_iam_user" "this" {
    for_each = var.user_names
    name = each.value
}