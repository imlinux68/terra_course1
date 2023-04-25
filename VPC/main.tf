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
  cidr_block = var.cidr_block[0]
  
  tags = {
    "Name" = "MyLab_VPC"
  }
}

# Create a subnet #

resource "aws_subnet" "MyLAB_sn1" {
  vpc_id = aws_vpc.MyLab_VPC.id
  cidr_block = var.cidr_block[1]

  tags = {
    "Name" = "MyLab-sn1"
  }
}

# Create Internet Gateway #

resource "aws_internet_gateway" "MyLab-IGW" {
  vpc_id = aws_vpc.MyLab_VPC.id

  tags = {
    Name = "MyLAB-internet_gateWay"
  }
}

# Create security group #

resource "aws_security_group" "MyLab-sg1" {
    name = "MyLab Security Group"
    description = "To allow inbound and outbound traffic for my lab"
    vpc_id = aws_vpc.MyLab_VPC.id

    dynamic ingress {
        iterator = port
        for_each = var.ports
        content {
            from_port = port.value
            to_port = port.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      "Name" = "allow traffic"
    }
  
}

# Create route table and association #

resource "aws_route_table" "MyLAB-rt1" {
  vpc_id = aws_vpc.MyLab_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MyLab-IGW.id
  }
}

resource "aws_route_table_association" "MyLAB_ASSN" {
  subnet_id = aws_subnet.MyLAB_sn1.id
  route_table_id = aws_route_table.MyLAB-rt1.id
}