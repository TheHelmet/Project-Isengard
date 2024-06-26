resource "aws_security_group" "security_group" {
  name        = "security_group"
  description = "firewall rules"
  vpc_id      = aws_vpc.vpc.id
}

# GENERAL

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.security_group.id
  description       = "all outbound"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
}


resource "aws_vpc_security_group_ingress_rule" "ssh_inbound_my_ip" {
  security_group_id = aws_security_group.security_group.id
  description       = "SSH Inbound from my IP"
  from_port         = 22
 cidr_ipv4         = "${coalesce(var.my_ip, "192.168.0.1")}/32"
 to_port           = 22
  ip_protocol       = "tcp"
}

#resource "aws_vpc_security_group_ingress_rule" "SSH_Inbound_ALL" {
#  security_group_id = aws_security_group.security_group.id
#  description       = "HTTP Inbound"
#  from_port         = 22
#  cidr_ipv4         = "0.0.0.0/0"
#  to_port           = 22
#  ip_protocol       = "tcp"
#}

resource "aws_vpc_security_group_ingress_rule" "teleport_inbound_my_ip" {
  security_group_id = aws_security_group.security_group.id
  description       = "Teleport Inbound from my IP"
  from_port         = 3025
 cidr_ipv4         = "${coalesce(var.my_ip, "192.168.0.1")}/32"
 to_port           = 3025
  ip_protocol       = "tcp"
}


resource "aws_vpc_security_group_ingress_rule" "internal" {
  security_group_id = aws_security_group.security_group.id
  description       = "Internal communication between hosts"
  cidr_ipv4         = aws_subnet.subnet.cidr_block
  ip_protocol       = -1
}

resource "aws_vpc_security_group_ingress_rule" "http_inbound_my_ip" {
  security_group_id = aws_security_group.security_group.id
  description       = "HTTP Inbound"
  from_port         = 80
  cidr_ipv4         = "${coalesce(var.my_ip, "192.168.0.1")}/32"
  to_port           = 80
  ip_protocol       = "tcp"
}
