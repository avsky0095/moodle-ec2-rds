server:
  hosts:
    ${ec2-pub-ip}:
    localhost:
    
  vars:
    ansible_ssh_private_key_file: assets/verifykeys/ec2-moodle.pem
    ansible_user: ubuntu