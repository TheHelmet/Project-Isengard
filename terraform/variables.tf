# metadata

variable "project" {
  type    = string
  default = "Isengard"
}

# provider information

variable "key_pair" {
  type    = string
  default = "Helmet-Keypair"
}

# network information

variable "my_ip" {
  type    = string
  default = ""
}

variable "pub_key" {
  type    = string
  default = ""
}

