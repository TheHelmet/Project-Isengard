output "server_ips" {
  value = { for i, inst in aws_instance.linux_server : inst.tags.Name => inst.public_ip }
  description = "The public IP addresses of the servers"
}
