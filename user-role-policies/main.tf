resource "aws_iam_user" "devops_user" {
  name = var.iam_username

  tags = {
    Environment = "Practice"
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_group" "devops_group" {
  name = var.iam_group_name
}

resource "aws_iam_policy" "s3_read_only" {
  name        = "TerraformS3ReadOnlyPolicy"
  description = "Allows read-only access to S3"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation",
          "s3:ListBucket",
          "s3:GetObject"
        ]

        Resource = ["*"]
      }
    ]
  })
}
resource "aws_iam_group_policy_attachment" "s3_policy_attachment" {
  group      = aws_iam_group.devops_group.name
  policy_arn = aws_iam_policy.s3_read_only.arn
}
resource "aws_iam_user_group_membership" "devops_membership" {
  user = aws_iam_user.devops_user.name

  groups = [
    aws_iam_group.devops_group.name
  ]
}
resource "aws_iam_role" "ec2_role" {
  name = "TerraformEC2S3ReadOnlyRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "ec2_s3_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_read_only.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "TerraformEC2InstanceProfile"
  role = aws_iam_role.ec2_role.name
}


