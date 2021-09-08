provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "webserver" {
  ami           = "ami-01e36b7901e884a10"
  instance_type = "t2.micro"

  tags = {
    Name = "webserver"
  }
  ebs_optimized = true

  metadata_options {
    http_endpoint = "disabled"
    http_tokens   = "required"
  }
}

resource "aws_s3_bucket" "accuricsbucketdemo" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name = "bucketdemo"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = "<target_bucket_name>"
  }

  versioning {
    enabled = true
  }
}
