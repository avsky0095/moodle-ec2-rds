variable "aws_region" {
  description = "AWS region on which we will setup the swarm cluster"
  default = "us-east-1"                 # Northern Virginia (AWS Educate)
}

variable "ami" {
  description = "Ubuntu Server 20.04 LTS (HVM), SSD Volume Type - ami-09e67e426f25ce0d7 (64-bit x86)"
  default = "ami-09e67e426f25ce0d7"     # Ubuntu 20.04 LTS 64bit
}

variable "instance_type" {
  description = "Instance type"
  default = "t2.medium"                 # 2 vCPU, 4 RAM
  # default = "t3a.micro"                 # 2 vCPU, 1 RAM
  # default = "t3a.small"                 # 2 vCPU, 2 RAM
}

variable "availability_zone"{
  description = "Availability Zone"
  default = "us-east-1f"                # Northern Virginia (AWS Educate), subnet 1F
}

variable "key_name" {
  description = "Desired name of Keypair..."
  default = "ec2-moodle"
}

variable "install_docker" {
  description = "Script to install Docker Engine"
  default = "install-docker.sh"
}