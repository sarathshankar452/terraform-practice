resource "aws_instance" "dev" {
  ami = "ami-08c46876c64a927b8"
  instance_type = "t3.micro"
  tags = {
    Name = "dev"
  }
}

resource "aws_s3_bucket" "dev" {
  bucket = "sharth-dev-prod-test-123-shankar-20261024-847291"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.dev.id

  versioning_configuration {
    status = "Enabled"
  }
}