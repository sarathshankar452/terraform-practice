terraform {
  backend "s3" {
    bucket         = "sarath-shankar-terraform-practice"
    key            = "sara/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    use_lockfile     = true #s3 native locking supported version 1.0.0 and above
    #dynamodb_table = "terraform-state-locks" # any version of terraform supports this
  }
}