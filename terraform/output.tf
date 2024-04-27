output "server_ips" {
  value = aws_instance.linux_server.*.public_ip
  description = "The public IP addresses of the servers"
}
