# Member 1's VPC (in their own project)
resource "google_compute_network" "member1_vpc" {
  provider = google.member1
  name = "member1-vpc"
  auto_create_subnetworks = false
}

# Subnet for Member 1
resource "google_compute_subnetwork" "member1_subnet" {
  provider = google.member1
  name = "member1-subnet"
  ip_cidr_range = var.member1_subnet_cidr
  network = google_compute_network.member1_vpc.id
}

# Member 2's VPC (in their own project)
resource "google_compute_network" "member2_vpc" {
  provider = google.member2
  name = "member2-vpc"
  auto_create_subnetworks = false
}

# Subnet for Member 2
resource "google_compute_subnetwork" "member2_subnet" {
  provider = google.member2
  name = "member2-subnet"
  ip_cidr_range = var.member2_subnet_cidr
  network = google_compute_network.member2_vpc.id
}

# Peering: Member 1 to Member 2
resource "google_compute_network_peering" "member1_to_member2" {
  provider = google.member1
  name = "member1-to-member2"
  network = google_compute_network.member1_vpc.self_link
  peer_network = google_compute_network.member2_vpc.self_link
}

resource "google_compute_network_peering" "member2_to_member1" {
  provider = google.member2
  name = "member2-to-member1"
  network = google_compute_network.member2_vpc.self_link
  peer_network = google_compute_network.member1_vpc.self_link
}

# Firewall rule to allow traffic between peers
resource "google_compute_firewall" "member1_allow_peer" {
  provider = google.member1
  name = "member1-allow-peer-traffic"
  network = google_compute_network.member1_vpc.name

  allow {
    protocol = "all" # Allow all traffic (restrict in production)
  }

  source_ranges = [var.member2_subnet_cidr] # Member 2's subnet CIDR
}

# Firewall rule to allow traffic between peers
resource "google_compute_firewall" "member2_allow_peer" {
  provider = google.member2
  name = "member1-allow-peer-traffic"
  network = google_compute_network.member2_vpc.name

  allow {
    protocol = "all" # Allow all traffic (restrict in production)
  }

  source_ranges = [var.member1_subnet_cidr] # Member 2's subnet CIDR
}