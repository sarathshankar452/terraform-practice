variable "sarath" {
  type = list(string)
  default = ["dev-1", "prod-1"]
}
resource "aws_instance" "name" {
    ami = "ami-0d27e0fb3bac4d724"
    instance_type = "t2.medium"
    for_each = toset(var.sarath)
    tags = {
        Name = var.sarath[count.index]
    }
  
}