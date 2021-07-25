terraform {
  required_providers {
    aws = {
      source              = "hashicorp/aws"
      version             = "~> 3.0"
    }
  }
}

# Aws provider and access details
provider "aws" {
  region                  = var.aws_region
  shared_credentials_file = "../credentials"
}

resource "aws_instance" "moodle-ec2" {
  ami                     = var.ami
  # associate_public_ip_address = false
  instance_type           = var.instance_type
  key_name                = var.key_name
  vpc_security_group_ids  = [aws_security_group.moodle-ec2-sg.id]
  availability_zone       = var.availability_zone
  user_data               = file(var.install_docker)

  tags = {
      Name                = "ec2-moodle"
  }

  ebs_block_device {
    device_name           = "/dev/sda1"
    volume_type           = "gp2"
    volume_size           = 8

  # tags = {
  #   Name = "MoodleVolume"
  #   }
  }

  credit_specification {
    cpu_credits           = "standard"
  }
}
