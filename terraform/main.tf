resource "aws_instance" "linux_server" {

  count                       = 0
  ami                         = "ami-08e168f4c7bff7921"
  instance_type               = "t2.medium"
  key_name                    = var.key_pair
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = ["${aws_security_group.security_group.id}"]

  root_block_device {
    delete_on_termination = true
    volume_size           = "15"
  }

  tags = {
    "Name"    = "Isengard-1
    "project" = var.project
  }

  user_data_base64 = base64encode(templatefile("cloudinit/userdata.tmpl", {
    gen_key = var.pub_key,
    install_script = base64encode(file("scripts/config_vnc.sh"))
  }))
}