terraform {
  backend "s3" {
    bucket = "mobilize-andy-test-terraform-state"
    key    = "terraform/terraform.tfstate"
    region = "eu-west-1"
    profile = "mobilize"
  }
}