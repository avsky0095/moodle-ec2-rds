
# ---------------------------------------------------------------
# AWS EC2 INSTANCE DEPLOYMENT
# ---------------------------------------------------------------

resource "aws_instance" "moodle-ec2" {
  tags = {
      Name                = "ec2-moodle"                        # ec2 host
  }

  ami                     = "ami-09e67e426f25ce0d7"             # Ubuntu 20.04 LTS 64 bit
  # ami                     = "ami-0ed9277fb7eb570c9"             # Amazon Linux 2 AMI (HVM)
  instance_type           = "t2.small"                          # 1 CPU, 2 RAM
  key_name                = "newkeyec2moodle"                   # aws private key 
  vpc_security_group_ids  = [aws_security_group.moodle-ec2-sg.id]  # Security group rules
  availability_zone       = "us-east-1f"                        # Northern Virginia, US

  ebs_block_device {                                            # Storage device
    device_name           = "/dev/sda1"
    volume_type           = "gp2"                               # General Purpose 2
    volume_size           = 8                                   # 8 GB
  }

  credit_specification {
    cpu_credits           = "standard"
  }
}


# ---------------------------------------------------------------
# [1] AWS RDS - MAIN INSTANCE DEPLOYMENT
# ---------------------------------------------------------------

# locals ------

locals {
  instance_class          = "db.t2.small"                       # 1 CPU, 2 GB RAM
  # instance_class          = "db.t2.medium"                       # 2 CPU, 4 GB RAM
}

resource "aws_db_instance" "moodle-rds"  {
  identifier              = "rds-moodle"                        # db host
  
  engine                  = "mariadb"                           # Database engine
  engine_version          = "10.4.13"                           # Versi database
  parameter_group_name    = "default.mariadb10.4"

  instance_class          = local.instance_class
  storage_type            = "gp2"                               # General Purpose 2
  allocated_storage       = 5

  name                    = "db_moodle"                         # db name
  username                = "user"
  password                = "user123!"
  availability_zone	      = "us-east-1f"
  port                    = "3306"
  vpc_security_group_ids  = [aws_security_group.moodle-rds-sg.id]

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
  identifier              = "rds-moodle-readreplica"            # db host
  replicate_source_db     = aws_db_instance.moodle-rds.id       # mereplika dari instance mana

  instance_class          = local.instance_class                # 1 CPU, 2 GB RAM
  name                    = "db_moodle_rr"                      # db name
  vpc_security_group_ids  = [aws_security_group.moodle-rds-sg.id]

  apply_immediately           = true                    # menerapkan perubahan segera
  skip_final_snapshot         = true                    # skip snapshot
  publicly_accessible         = false                   # diakses publik
  auto_minor_version_upgrade  = false                   # mematikan pembaharuan minor
}
