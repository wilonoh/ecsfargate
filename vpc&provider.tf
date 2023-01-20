#vpc
resource "aws_vpc" "e-learning" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support

  tags = {
    Name = "e-learning-${terraform.workspace}"
  }
}

#provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}