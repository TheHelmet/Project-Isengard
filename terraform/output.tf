output "server_ips" {
  value = aws_instance.example_server.*.public_ip
  description = "The public IP addresses of the servers"
}
