
# ---------------------------------------------------------------
# AWS EC2 INSTANCE DEPLOYMENT
# ---------------------------------------------------------------

resource "aws_instance" "moodle-ec2" {
  tags = {
      Name                = "ec2-moodle"                        # ec2 host
  }

  ami                     = "ami-09e67e426f25ce0d7"             # Ubuntu 20.04 LTS 64 bit
  instance_type           = "t2.small"                          # 1 CPU, 2 RAM
  key_name                = "ec2-moodle"                        # aws public key 
  vpc_security_group_ids  = [aws_security_group.moodle-ec2.id]  # Security group rules
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



# locals ------

locals {
  engine                  = "mariadb"                           # Database engine
  engine_version          = "10.4.13"                           # Versi database
  parameter_group_name    = "default.mariadb10.4"
  instance_class          = "db.t2.small"                       # 1 CPU, 2 GB RAM
}


# ---------------------------------------------------------------
# [1] AWS RDS - MAIN INSTANCE DEPLOYMENT
# ---------------------------------------------------------------

resource "aws_db_instance" "moodle-rds"  {
  identifier              = "rds-moodle"                        # db host
  
  engine                  = local.engine                        # Database engine
  engine_version          = local.engine_version                # Versi database

  instance_class          = local.instance_class                # 1 CPU, 2 GB RAM
  storage_type            = "gp2"                               # General Purpose 2
  allocated_storage       = 5
  max_allocated_storage   = 0                                   # disable autoscaling

  name                    = "db_moodle"                         # db name
  username                = "user"
  password                = "user123!"
  availability_zone	      = "us-east-1f"
  port                    = "3306"
  vpc_security_group_ids  = [aws_security_group.moodle-rds.id]
  parameter_group_name    = local.parameter_group_name

  monitoring_interval                 = 0                       # mematikan enhanced monitoring
  backup_retention_period             = 1                       # hari, backup hanya pada main db, tidak replica
  maintenance_window                  = null                    # mematikan maintenance
  backup_window                       = null                    # mematikan backup
  apply_immediately                   = true                    # menerapkan perubahan segera
  skip_final_snapshot                 = true                    # skip snapshot
  publicly_accessible                 = true                    # diakses publik
  storage_encrypted                   = false
  iam_database_authentication_enabled = false
  auto_minor_version_upgrade          = false                   # mematikan pembaharuan minor
  deletion_protection                 = false                   # mematikan proteksi penghapusan
}


# ---------------------------------------------------------------
# [2] AWS RDS - READ REPLICA INSTANCE DEPLOYMENT
# ---------------------------------------------------------------

resource "aws_db_instance" "moodle-rds-readreplica"  {
  identifier              = "rds-moodle-readreplica"            # db host
  replicate_source_db     = aws_db_instance.moodle-rds.id       # mereplika dari instance mana

  # engine                  = local.engine                        # Database engine
  # engine_version          = local.engine_version                # Versi database

  # instance_class          = local.instance_class                # 1 CPU, 2 GB RAM
  # storage_type            = "gp2"                               # General Purpose 2
  # allocated_storage       = 5             
  # max_allocated_storage   = 0                                   # disable autoscaling

  name                    = "db_moodle_rr"                      # db name
  # username                = "user"
  # password                = "user123!"
  # availability_zone	      = "us-east-1f"
  # port                    = "3306"
  vpc_security_group_ids  = [aws_security_group.moodle-rds.id]
  parameter_group_name    = local.parameter_group_name

  monitoring_interval                 = 0
  maintenance_window                  = null                    # mematikan maintenance
  backup_window                       = null                    # mematikan backup
  apply_immediately                   = true                    # menerapkan perubahan segera
  skip_final_snapshot                 = true                    # skip snapshot
  publicly_accessible                 = true                    # diakses publik
  storage_encrypted                   = false
  iam_database_authentication_enabled = false
  auto_minor_version_upgrade          = false                   # mematikan pembaharuan minor
  deletion_protection                 = false                   # mematikan proteksi penghapusan
}
