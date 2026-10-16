variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "iam_username" {
  description = "IAM username"
  type        = string
  default     = "devops-user"
}

variable "iam_group_name" {
  description = "IAM group name"
  type        = string
  default     = "devops-group"
}