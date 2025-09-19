# ./infra/backend.tf
terraform {
  backend "s3" {
    bucket       = "astro-1745"
    key          = "envs/terraform.tfstate"  # default workspace state
    region       = "ap-south-1"
    encrypt      = true
    dynamodb_table = "terraform-lock-table"
  }
}
