
output "public_dns" {
  description = "List of public DNS addresses assigned to the instances, if applicable"
  value       = [aws_instance.moodle-ec2.public_dns]
}

# Generate Hosts Inventory
# resource "local_file" "AnsibleHosts" {
#     filename = "./inventory/hosts"
#     content = templatefile("hosts.tmpl",
#         {
#             moodleIp = aws_instance.moodle.public_ip,
#         }
#     )
# }