# Note: need environment variables
# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY
provider "aws" {
  version = "~> 2.1.0"
  region  = "${var.aws_region}"
}

terraform {
  required_version = "~> 0.11.11"
}

provider "archive" {
  version = "~> 1.1"
}
