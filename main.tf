terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.96.0"
    }
  }
  backend "s3" {
    bucket = "terraformvpcadsa"
    key    = "aws-vpc/vpchomol/terraformhomol.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
      owner = "AdrianoAngelo-vpc-homol"
    }
  }
}
