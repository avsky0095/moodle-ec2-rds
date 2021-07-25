provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "../credentials"
}

module "db" {
  source                = "terraform-aws-modules/rds/aws"
  version               = "~> 3.0"

  identifier            = "moodle-rds-test"

  engine                = "mysql"
  engine_version        = "8.0.23"
  instance_class        = "db.t2.small" # 1 vCPU, 2 RAM
  storage_type          = "gp2"         
  allocated_storage     = 5             # GB
  max_allocated_storage = 0             # disable autoscaling
  storage_encrypted     = false

  name                  = "moodle-rds"
  username              = "user"
  password              = "user123!"
  port                  = "3306"

  availability_zone	    = "us-east-1f"
  iam_database_authentication_enabled = false
  vpc_security_group_ids = [moodle-rds-sg.id]

  maintenance_window    = null
  backup_window         = null

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
#   monitoring_interval = "30"
#   monitoring_role_name = "MyRDSMonitoringRole"
#   create_monitoring_role = true

  # tags = {
  #   Owner       = "user"
  #   Environment = "dev"
  # }

  # DB subnet group
  subnet_ids                  = ["subnet-1c7dc63d", "subnet-7a6e1874"] # A, F

  # DB parameter group
  family                      = "mysql8.0"
  major_engine_version        = "8.0"

  apply_immediately           = true
  skip_final_snapshot         = true    
  publicly_accessible         = false   
  auto_minor_version_upgrade  = false
  deletion_protection         = false

   # parameters = [
  #   {
  #     name = "character_set_client"
  #     value = "utf8mb4"
  #   },
  #   {
  #     name = "character_set_server"
  #     value = "utf8mb4"
  #   }
  # ]

#   options = [
#     {
#       option_name = "MARIADB_AUDIT_PLUGIN"

#       option_settings = [
#         {
#           name  = "SERVER_AUDIT_EVENTS"
#           value = "CONNECT"
#         },
#         {
#           name  = "SERVER_AUDIT_FILE_ROTATIONS"
#           value = "37"
#         },
#       ]
#     },
#   ]
}

