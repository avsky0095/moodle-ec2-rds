
PROJECT MOODLE SEDERHANA EC2 DAN RDS (PROJECT SKRIPSI/TA)

# moodle-ec2-rds
Terraform configuration script

# main.tf
# required: AWS credentials file

- terraform init
- terraform plan
- terraform apply

Alur eksekusi:
- main.tf
  - RDS
  - EC2
- security-group.tf
- run-script.sh
  - Docker
  - docker-compose up
- vars.tf