server:
  hosts:
    "${ec2-pub-ip}":
    
  vars:
    ansible_ssh_private_key_file: /home/andrianovsky/Documents/Moodle-on-AWS/Script/assets/verifykeys/ec2-moodle.pem