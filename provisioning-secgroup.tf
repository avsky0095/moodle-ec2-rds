# ---------------------------------------------------------------
# PROVIDERS
# ---------------------------------------------------------------

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
  shared_credentials_file = "assets/verifykeys/aws-credentials"   # alamat file credentials AWSEducate
}

# ---------------------------------------------------------------
# PROVISIONING
# ---------------------------------------------------------------

resource "null_resource" "moodle-compose-up" {
  depends_on = [
    aws_db_instance.moodle-rds-readreplica
  ]

  provisioner "file" {                                                  # file docker-compose.yml, install-docker.sh, config.php
    source                = "assets/file-transfer/"                     # transfer folder ke direktori
    destination           = "/home/ubuntu/"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x install-docker.sh",
      "./install-docker.sh"
    ]
  }

  connection {
    agent                 = false
    type                  = "ssh"
    user                  = "ubuntu"
    password              = ""
    host                  = "${aws_instance.moodle-ec2.public_dns}"
    private_key           = file("assets/verifykeys/newkeyec2moodle.pem")                     # lokasi file private key
  }  
}


# ---------------------------------------------------------------
# DEFINITION OF SECURITY GROUP RULES
# ---------------------------------------------------------------

resource "aws_security_group" "moodle-ec2-sg" {

  ingress {
    description      = "ALL"
    from_port        = 0
    to_port          = 0
    self             = true
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Allow all Outbound 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


resource "aws_security_group" "moodle-rds-sg" {

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "MySQL access from within VPC"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


# ---------------------------------------------------------------
# OUTPUTS
# ---------------------------------------------------------------

#----- OUTPUTS

output "ec2_public_dns" {
  description             = "List of public DNS addresses assigned to the instances, if applicable"
  value                   = [aws_instance.moodle-ec2.public_dns]
}

output "rds_address" {
  description             = "The hostname of the RDS instance"
  value                   = [aws_db_instance.moodle-rds.address]
}

output "rds_address_rr" {
  description             = "The hostname of the RDS instance"
  value                   = [aws_db_instance.moodle-rds-readreplica.address]
}



#----- INSTANCES GET IP

# resource "local_file" "docker-compose" {
#   filename = "assets/file-transfer/docker-compose.yml"
#   content = templatefile("assets/file-transfer/docker-compose.tpl",
#     {
#       ec2-pub-ip = aws_instance.moodle-ec2.public_dns
#       rds-pub-ip = aws_db_instance.moodle-rds.address
#     }
#   )
# }