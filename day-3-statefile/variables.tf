variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone for EC2"
  type        = string
}

variable "instance_name" {
  description = "Name tag for EC2 instance"
  type        = string
}