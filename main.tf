
# ---------------------------------------------------------------
# AWS EC2 INSTANCE DEPLOYMENT
# ---------------------------------------------------------------

resource "aws_instance" "moodle-ec2" {
  tags = {
      Name                = "ec2-moodle"                        # ec2 host
  }

  ami                     = "ami-09e67e426f25ce0d7"             # Ubuntu 20.04 LTS 64 bit
  instance_type           = var.ec2_instance_type               # 1 CPU, 2 RAM
  key_name                = var.keypair                         # aws private key 
  vpc_security_group_ids  = [aws_security_group.moodle-ec2-sg.id]  # Security group rules
  availability_zone       = var.availability_zone               # Northern Virginia, US

  ebs_block_device {                                            # Storage device
    device_name           = "/dev/sda1"
    volume_type           = "gp2"                               # General Purpose 2
    volume_size           = 8                                   # 8 GB
  }

  credit_specification {
    cpu_credits           = "standard"
  }

  user_data = <<USERDATA
              #!/bin/bash
              apt update -y 
              echo "PUBLIC_DNS=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)" >> .env
              echo "DB_HOST=${aws_db_instance.moodle-rds.address}" > .env
              echo "DB_NAME=${aws_db_instance.moodle-rds.name}" > .env
              echo "DB_USER=${aws_db_instance.moodle-rds.username}" > .env
              echo "DB_PASS=${aws_db_instance.moodle-rds.password}" > .env
              echo "MDL_USER=${var.moodle_user}" > .env
              echo "MDL_PASS=${var.moodle_pass}" > .env
  USERDATA
}


# ---------------------------------------------------------------
# [1] AWS RDS - MAIN INSTANCE DEPLOYMENT
# ---------------------------------------------------------------

# locals ------

locals {
  instance_class              = var.rds_instance_type               # 1 CPU, 2 GB RAM
}

resource "aws_db_instance" "moodle-rds"  {
  identifier                  = "rds-moodle"                        # db host
  
  engine                      = "mariadb"                           # Database engine
  engine_version              = "10.4.13"                           # Versi database
  parameter_group_name        = "default.mariadb10.4"

  instance_class              = local.instance_class
  storage_type                = "gp2"                               # General Purpose 2
  allocated_storage           = 5

  name                        = "db_moodle"                         # db name
  username                    = var.db_user
  password                    = var.db_pass
  availability_zone	          = var.availability_zone
  port                        = "3306"
  vpc_security_group_ids      = [aws_security_group.moodle-rds-sg.id]

  apply_immediately           = true                    # menerapkan perubahan segera
  skip_final_snapshot         = true                    # skip snapshot
  publicly_accessible         = false                   # diakses publik
  auto_minor_version_upgrade  = false                   # mematikan pembaharuan minor

  # khusus untuk skenario read-replica
  backup_retention_period     = 1                       # hari, backup hanya pada main db, tidak replica
}


# ---------------------------------------------------------------
# [2] AWS RDS - READ-REPLICA INSTANCE DEPLOYMENT
# ---------------------------------------------------------------

resource "aws_db_instance" "moodle-rds-readreplica"  {
  identifier                  = "rds-moodle-readreplica"            # db host
  replicate_source_db         = aws_db_instance.moodle-rds.id       # mereplika dari instance mana

  instance_class              = local.instance_class                # 1 CPU, 2 GB RAM
  name                        = "db_moodle_rr"                      # db name
  vpc_security_group_ids      = [aws_security_group.moodle-rds-sg.id]

  apply_immediately           = true                    # menerapkan perubahan segera
  skip_final_snapshot         = true                    # skip snapshot
  publicly_accessible         = false                   # diakses publik
  auto_minor_version_upgrade  = false                   # mematikan pembaharuan minor
}
