terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        versversion = "~>3.0"
    }
  }
}


# Config aws prowider #

provider "aws" {
  region = "us-west-2"
}

# Create a VPC #

resource "aws_vpc" {
  cidr_block = "172.20.0.0/16"
}