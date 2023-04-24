# terraform {
#   required_providers {
#     aws = {
#         source = "hashicorp/aws"
#         version = "~>3.0"
#     }
#   }
# }


# Config aws prowider #

provider "aws" {
  region = "us-west-2"
}

# Create a VPC #

resource "aws_vpc" "MyLab_VPC" {
  cidr_block = "172.20.0.0/16"
  
  tags = {
    "Name" = "MyLab_VPC"
  }
}