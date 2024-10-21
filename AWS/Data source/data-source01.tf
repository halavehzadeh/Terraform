data "local_file" "foo" {
  filename = "${path.module}/demo.txt"
}

output data {
  value       = data.local_file.foo.content

}
