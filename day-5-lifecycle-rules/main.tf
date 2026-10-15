resource "aws_instance" "name" {
    ami = "ami-0c766c2cff1b35ed2"
    instance_type = "t3.micro"
    availability_zone = "us-west-2b"
    tags = {
        Name = "shan"
    }

  
  lifecycle {
     ignore_changes = [tags]
   }
#lifecycle {
  #create_before_destroy = true
#}

# lifecycle {
#    prevent_destroy = true
# }
}