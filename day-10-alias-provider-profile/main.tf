resource "aws_instance" "name" {
    ami = "ami-002192a70217ac181"
    instance_type = "t2.micro"
    tags = {
        Name = "dev-2"
    }
  #us-east-1
}

provider "aws" {
  region  = "us-east-1"
  alias   = "dev"
  profile = "dev"
}

resource "aws_s3_bucket" "name" {
  provider = aws.dev
  bucket   = "sharath-shankar-ungati-dev"
}