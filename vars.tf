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
# PROVISIONING / MOODLE DOCKER COMPOSE + MONITORING DEPLOYMENT
# ---------------------------------------------------------------

resource "null_resource" "moodle-compose-up" {
  depends_on = [
    aws_instance.moodle-ec2
  ]

  provisioner "file" {                                                  # file docker-compose.yml, install-docker.sh, prometheus.yml
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
    type                  = "ssh"
    user                  = "ubuntu"
    password              = ""
    host                  = "${aws_instance.moodle-ec2.public_dns}"
    private_key           = file("assets/verifykeys/ec2-moodle.pem")                     # lokasi file private key
  }  
}


# ---------------------------------------------------------------
# DEFINITION OF VARIABLES, OUTPUTS, ETC
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

# output "rds_address_rr" {
#   description             = "The hostname of the RDS instance"
#   value                   = [aws_db_instance.moodle-rds-readreplica.address]
# }


#----- ANSIBLE GET IP

resource "local_file" "AnsibleInventory" {
  filename = "assets/ansible/inventory.yaml"
  content = templatefile("assets/ansible/inventory.tpl",
    {
      ec2-pub-ip = aws_instance.moodle-ec2.public_dns
    }
  )
}