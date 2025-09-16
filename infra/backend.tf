# ./infra/backend.tf
terraform {
  backend "s3" {
    bucket         = "astro-1745"        # Must exist in AWS
    key            = "envs/dev/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"             # Optional but recommended
  }
}
