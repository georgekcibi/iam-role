terraform {
    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "~> 4.0"
      }
    }
}


provider "aws" {
    profile = "terraform"
    region  = "us-east-1"
}

resource "aws_iam_role" "test_role" {
    name = "test_role"
    assume_role_policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
      ]
    }

    )
}

resource "aws_iam_role_policy_attachment" "test-attach" {
    role = aws_iam_role.test_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"

}
