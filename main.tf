# Define the region
# $ export AWS_ACCESS_KEY_ID="anaccesskey"
# $ export AWS_SECRET_ACCESS_KEY="asecretkey"
# $ export AWS_DEFAULT_REGION="us-east-1"
provider "aws" {
    region = var.region
    version = "~> 2.70"
}

