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
  region                  = "us-east-1"
  shared_credentials_file = "credentials"
}

#############################
# AWS ELASTIC CLOUD COMPUTING
#############################

resource "aws_instance" "moodle-ec2" {
  ami                     = "ami-09e67e426f25ce0d7"             # Ubuntu 20.04 LTS 64 bit
  instance_type           = "t2.medium"                         # 2 vCPU, 4 RAM
  key_name                = "ec2-moodle"                        # private key file
  vpc_security_group_ids  = [aws_security_group.moodle-ec2.id]  # Security group rules
  availability_zone       = "us-east-1f"                        # Northern Virginia, US
  user_data               = "install_docker.sh"                 # Proses instalasi Docker

  tags = {                                                        
      Name                = "ec2-moodle"                        # Penamaan
  }

  ebs_block_device {                                            # Storage device
    device_name           = "/dev/sda1"
    volume_type           = "gp2"                               # General Purpose 2
    volume_size           = 8                                   # 8 GB
  }

  credit_specification {
    cpu_credits           = "standard"                            
  }
}

#################################
# AWS RELATIONAL DATABASE SERVICE
#################################

module "db" {
  source                  = "terraform-aws-modules/rds/aws"       # provider untuk AWS-RDS
  version                 = "~> 3.0"

  engine                  = "mysql"                               # Database engine
  engine_version          = "8.0.23"                              # Versi database
  family                  = "mysql8.0"
  major_engine_version    = "8.0"

  instance_class          = "db.t2.small"                         # 1 vCPU, 2 RAM     
  storage_type            = "gp2"                                 # General Purpose 2
  allocated_storage       = 5                                     # 5 GB
  max_allocated_storage   = 0                                     # disable autoscaling
  storage_encrypted       = false

  identifier              = "moodle-rds-test"
  name                    = "moodle-rds"
  username                = "user"
  password                = "user123!"
  availability_zone	      = "us-east-1f"
  port                    = "3306"

  subnet_ids              = ["subnet-1c7dc63d", "subnet-7a6e1874"] # Subnet A, F

  iam_database_authentication_enabled = false
  vpc_security_group_ids              = [aws_security_group.moodle-rds.id]

  maintenance_window                  = null        # mematikan maintenance
  backup_window                       = null        # mematikan backup
  apply_immediately                   = true        # menerapkan perubahan segera
  skip_final_snapshot                 = true        # skip snapshot 
  publicly_accessible                 = false       # tidak diakses publik
  auto_minor_version_upgrade          = false       # mematikan pembaharuan minor
  deletion_protection                 = false       # mematikan proteksi penghapusan

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  # monitoring_interval = "30"
  # monitoring_role_name = "MyRDSMonitoringRole"
  # create_monitoring_role = true

  # tags = {
  #   Owner       = "user"
  #   Environment = "dev"
  # }
}
