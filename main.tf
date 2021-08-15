terraform {
  required_providers {
    aws = {
      source              = "hashicorp/aws"
      version             = "~> 3.0"
    }
  }
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "credentials"                       # alamat file credentials
}


#################################
# AWS RELATIONAL DATABASE SERVICE
#################################

resource "aws_db_instance" "moodle-rds"  {
  engine                  = "mariadb"                           # Database engine
  engine_version          = "10.4.13"                           # Versi database

  instance_class          = "db.t2.small"                       # 1 CPU, 2 RAM
  storage_type            = "gp2"                               # General Purpose 2
  allocated_storage       = 5                                   # 5 GB
  max_allocated_storage   = 0                                   # disable autoscaling
  storage_encrypted       = false

  identifier              = "rdsmoodletest"
  name                    = "rds_moodle"
  username                = "user"
  password                = "user123!"
  availability_zone	      = "us-east-1f"
  port                    = "3306"

  iam_database_authentication_enabled = false
  vpc_security_group_ids              = [aws_security_group.moodle-rds.id]

  maintenance_window                  = null                    # mematikan maintenance
  backup_window                       = null                    # mematikan backup
  apply_immediately                   = true                    # menerapkan perubahan segera
  skip_final_snapshot                 = true                    # skip snapshot
  publicly_accessible                 = true                    # diakses publik
  auto_minor_version_upgrade          = false                   # mematikan pembaharuan minor
  deletion_protection                 = false                   # mematikan proteksi penghapusan
}

output "rds_address" {
  description   = "The hostname of the RDS instance"
  value         = [aws_db_instance.moodle-rds.address]
}


#############################
# AWS ELASTIC CLOUD COMPUTING
#############################

resource "aws_instance" "moodle-ec2" {
  depends_on = [
    aws_db_instance.moodle-rds
  ]

  ami                     = "ami-09e67e426f25ce0d7"             # Ubuntu 20.04 LTS 64 bit
  instance_type           = "t2.small"                          # 1 CPU, 2 RAM
  key_name                = "ec2-moodle"                        # private key file
  vpc_security_group_ids  = [aws_security_group.moodle-ec2.id]  # Security group rules
  availability_zone       = "us-east-1f"                        # Northern Virginia, US

  tags = {
      Name                = "ec2-moodle-test"                   # Penamaan
  }

  ebs_block_device {                                            # Storage device
    device_name           = "/dev/sda1"
    volume_type           = "gp2"                               # General Purpose 2
    volume_size           = 8                                   # 8 GB
  }

  credit_specification {
    cpu_credits           = "standard"
  }

#############
  provisioner "file" {                                          # file
    source                = "passing-box"                       # transfer folder ke direktori
    destination           = "/home/ubuntu"
  }

  provisioner "remote-exec" {
    inline = [
      "cd $HOME/passing-box",
      "chmod +x run-script.sh",
      "./run-script.sh"
    ]
  }

  connection {
    type                  = "ssh"
    user                  = "ubuntu"
    password              = ""
    host                  = "${aws_instance.moodle-ec2.public_dns}"
    private_key           = file("ec2-moodle.pem")                      # lokasi file private key
  }
}

output "ec2_public_dns" {
  description             = "List of public DNS addresses assigned to the instances, if applicable"
  value                   = [aws_instance.moodle-ec2.public_dns]
}

