# metadata

variable "project" {
  type    = string
  default = "Isengard"
}

# provider information

variable "key_pair" {
  type    = string
  default = "helmet-keypair"
}

# network information

variable "my_ip" {
  type    = string
}

variable "runner_access_enabled" {
  type    = bool
  default = true
} 

