
// Create and store ALL VARIABLES SETUP IN "terraform.tfvars" files

variable "region" {
  description   = "region used"
  type          = string
  default       = "us-east-1"   
}

variable "availability_zone" {
  description   = "AZ for ec2"
  type          = string
  default       = "us-east-1f" 
}

variable "keypair" {
  description   = "keypair for ec2 instance"
  type          = string
  sensitive     = true
  default       = "DEFINE_YOUR_KEYPAIR_FIRST!"
}

variable "ec2_instance_type" {
  description   = "globally define instant type for EC2"
  type          = string
  default       = "t2.micro"
}

variable "rds_instance_type" {
  description   = "globally define instant type for RDS"
  type          = string
  default       = "db.t2.micro"
}

variable "db_user" {
  description   = "database rds username"
  type          = string
  sensitive     = true
  default       = "dbuser"  
}

variable "db_pass" {
  description   = "database rds password"
  type          = string
  sensitive     = true
  default       = "dbpass"  
}

variable "moodle_user" {
  description   = "moodle username"
  type          = string
  sensitive     = true
  default       = "admin"  
}

variable "moodle_pass" {
  description   = "moodle password"
  type          = string
  sensitive     = true
  default       = "admin123!"  
}