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
      name = "auth-server"
    }
  }


}

provider "aws" {
  region  = "ap-northeast-2"
}

