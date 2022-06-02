terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.75.2"
    }
  }

  required_version = ">= 0.14.9"

  cloud {
    organization = "pj4terraform"

    workspaces {
      name = "devcloud"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

output "vpc_id" {
  value = aws_vpc.aws-vpc.id
}
output "aws_security_group_id" {
  value =  aws_security_group.load_balancer_security_group.id
}
output "aws_subnet_public_id" {
  value =  aws_subnet.public.*.id
}
output "aws_subnet_private_id" {
  value =  aws_subnet.private.*.id
}
output "aws_tg_id" {
  value = aws_lb_target_group.target_group.id  
}
output "aws_tg_id2" {
  value = aws_lb_target_group.target_group2.id
}