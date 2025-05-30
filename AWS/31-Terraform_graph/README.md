# Terraform Graph
Terraform Graph refers to a visual representation of the dependency relationships between resources defined in your Terraform configuration.

![MY Image](images/geraph-1.png)

terraform-graph.tf

```
resource "aws_eip" "lb" {
  domain   = "vpc"
}

resource "aws_security_group" "example" {
  name        = "attribute-sg"
}

resource "aws_vpc_security_group_ingress_rule" "example" {
  security_group_id = aws_security_group.example.id

  cidr_ipv4   = "${aws_eip.lb.public_ip}/32"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_instance" "web" {
  ami           = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"
}

```

Terraform graph are a valuable tools for visualizing and understanding the relationships between resources in your infrastructure defined with Terraform.
It can improve your overall workflow by aiding in planning, debugging, and managing complex infrastructure configurations.