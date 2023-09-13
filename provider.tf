terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "terraform-wp-project-backend-s3"
    key    = "terraform-wp-project-backend-s3/terraform-state-key"
    region = "eu-west-2"
  }
}

provider "aws" {
  region     = "eu-west-2"
  access_key = ""
  secret_key = ""
}

