module "moodle-rds-sg" {
  source = "terraform-aws-modules/security-group/aws"

#   name        = "moodle-rds-sg"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
#   vpc_id      = "vpc-rds-moodle"

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
    #   cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]
}