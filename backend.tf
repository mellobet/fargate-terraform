# Remote Backend
terraform {
  backend "s3" {
    bucket = "ml-terraform-backend"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
