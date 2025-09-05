# Variable for the Terraform configuration
variable "invictus_subnet_cidr" {
  description = "Invictus Inc. subnet CIDR range"
  type = string
  default = "10.11.0.0/24"
}

# Member1 Subnet CIDR Range
variable "member1_subnet_cidr" {
  description = "Member 1 subnet CIDR range"
  type = string
  default = "192.168.1.0/24"
}

# Member2 Subnet CIDR Range
variable "member2_subnet_cidr" {
  description = "CIDR for Member 2's subnet"
  type = string
  default = "192.168.2.0/24"
}

# VPN Shared Secret
variable "vpn_shared_secret" {
  description = "Shared secret for the VPN connection"
  type = string
  sensitive = true
  default = "9VajgP1xYgtYCnUavsOJLL2nP2lTJwdFZPLYtzwfTjeQoM9SomamLq1nBAiwaRnT"
}

# Variables for the Terraform configuration
variable "invictus_project_id" {
  description = "Invictus Inc. GCP project ID"
  type = string
  default = "invictus-65"
}

variable "member1_project_id" {
  description = "Member 1 GCP project ID"
  type = string
  default = "service-p1-462917"
}

variable "member2_project_id" {
  description = "Member 2 GCP project ID"
  type = string
  default = "service-p2-462917"
}

