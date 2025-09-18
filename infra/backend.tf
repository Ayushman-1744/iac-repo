# ./infra/backend.tf
terraform {
  backend "s3" {
    bucket       = "astro-1745"
    key          = "envs/dev/terraform.tfstate"  # default workspace state
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}