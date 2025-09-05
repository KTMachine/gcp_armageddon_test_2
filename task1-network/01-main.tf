# Invictus Inc. VPC Configuration
resource "google_compute_network" "invictus_vpc" {
  name = "invictus-vpc"
  auto_create_subnetworks = false
}

#Subnet for Invictus Inc.
resource "google_compute_subnetwork" "invictus_subnet" {
  name = "invictus-subnet"
  ip_cidr_range = var.invictus_subnet_cidr
  network = google_compute_network.invictus_vpc.id
}

# VPN Gateway
resource "google_compute_vpn_gateway" "invictus_gateway" {
  name = "invictus-vpn-gw"
  network = google_compute_network.invictus_vpc.id
}

# VPN Gateway IP Address
resource "google_compute_address" "invictus_vpn_ip" {
  name = "invictus-vpn-ip"
  region = "us-central1"
  project = var.invictus_project_id
}

# VPN Tunnel to Member 1
resource "google_compute_address" "member1_vpn_ip" {
  provider = google.member1
  name   = "member1-vpn-ip"
  region = "europe-west1" # Use the correct region for member1
  project = var.member1_project_id
}

# VPN Tunnel to Member 2
resource "google_compute_address" "member2_vpn_ip" {
  provider = google.member2
  name   = "member2-vpn-ip"
  region = "asia-southeast1" # Use the correct region for member2
  project = var.member2_project_id
}


# Forwarding rule for ESP protocol
resource "google_compute_forwarding_rule" "invictus_esp" {
  name        = "invictus-esp-forwarding-rule"
  region      = "us-central1"
  ip_protocol = "ESP"
  target      = google_compute_vpn_gateway.invictus_gateway.id
  ip_address  = google_compute_address.invictus_vpn_ip.address
}

#Forwarding rule for UDP port 500
resource "google_compute_forwarding_rule" "invictus_udp500" {
  name        = "invictus-udp500-forwarding-rule"
  region      = "us-central1"
  ip_protocol = "UDP"
  port_range  = "500"
  target      = google_compute_vpn_gateway.invictus_gateway.id
  ip_address  = google_compute_address.invictus_vpn_ip.address
}

#Forwarding rule for UDP port 4500
resource "google_compute_forwarding_rule" "invictus_udp4500" {
  name        = "invictus-udp4500-forwarding-rule"
  region      = "us-central1"
  ip_protocol = "UDP"
  port_range  = "4500"
  target      = google_compute_vpn_gateway.invictus_gateway.id
  ip_address  = google_compute_address.invictus_vpn_ip.address
}