module "dev" {
    source = "../day-6-ec2-module"
    ami_id  = "ami-0c766c2cff1b35ed2"
    instance_type = "t3.micro"  
    az = "us-west-2b"
    
}