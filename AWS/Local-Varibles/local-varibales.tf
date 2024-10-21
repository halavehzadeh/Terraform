provider "aws" {
  region     = "us-east-1"
}

variable "tags" {
  type        = map
  default     = {
    Team = "security-team"
    
  }
  description = "Define Varibles"
}

locals {
  default = {
    Team = "security-teams"
    CreationDate = "date-${formatdate("DDMMYYYY",timestamp())}"
  }
}


resource "aws_security_group" "sg_01" {
  name = "app_firewall"
  tags =  local.default
}

resource "aws_security_group" "sg_02" {
  name = "db_firewall"
  tags = local.default
}