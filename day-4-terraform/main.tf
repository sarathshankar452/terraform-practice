resource "aws_instance" "name" {
    ami = "ami-0c766c2cff1b35ed2"
    instance_type = "t3.micro"
    availability_zone = "us-west-2b"
    tags = {
        Name = "sara"
    }

  
}