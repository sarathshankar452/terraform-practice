resource "aws_instance" "name" {
    ami = "ami-0c766c2cff1b35ed2"
    instance_type = "t3.micro"
    availability_zone = "us-west-2b"
    tags = {
        Name = "shankar"
    }
}

resource "aws_s3_bucket" "name" {
    bucket = "sarath-shankar-123456"
  
}

#terraform plan -target=aws_s3_bucket.name #we can apply specifc respource by using targets