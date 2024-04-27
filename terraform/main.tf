resource "aws_instance" "linux_server" {

  count                       = 17
  ami                         = "ami-08e168f4c7bff7921"
  instance_type               = "t2.micro"
  key_name                    = var.key_pair
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = ["${aws_security_group.security_group.id}"]

  root_block_device {
    delete_on_termination = true
    volume_size           = "15"
  }

  tags = {
    "Name" = "Isengard-${count.index + 1}"  # Unique name for each server
    "project" = var.project
  }

  user_data_base64 = base64encode(templatefile("cloudinit/userdata.tmpl", {
  }))
}


resource "aws_instance" "nginx_server" {

  count                       = 1
  ami                         = "ami-08e168f4c7bff7921"
  instance_type               = "t2.micro"
  key_name                    = var.key_pair
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = ["${aws_security_group.security_group.id}"]

  root_block_device {
    delete_on_termination = true
    volume_size           = "15"
  }

  tags = {
    "Name" = "Isengard-${count.index + 1}"  # Unique name for each server
    "project" = var.project
  }

user_data = <<-EOF
              #!/bin/bash
              # Install Docker
              sudo apt-get update
              sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
              sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
              sudo apt-get update
              sudo apt-get install -y docker-ce

              # Start Docker service
              sudo systemctl start docker
              sudo systemctl enable docker

              # Pull and run Docker container
              sudo docker pull nginx  # Replace 'nginx' with your specific image
              sudo docker run -d -p 80:80 nginx  # Replace 'nginx' and ports with your specific configuration
              EOF
}
