# VPC in Invictus INC Project (shred with members)
resource "google_compute_network" "main_vpc" {
  project = var.invictus_project_id
  name = "multi-region-vpc"
  auto_create_subnetworks = false
}

# VPC in Member 1 Project
resource "google_compute_network" "member1_vpc" {
  provider = google.member1
  project = var.member1_project_id
  name = "member1-vpc"
  auto_create_subnetworks = false
}

# VPC in Member 2 Project
resource "google_compute_network" "member2_vpc" {
  provider = google.member2
  project = var.member2_project_id
  name = "member2-vpc"
  auto_create_subnetworks = false
}

# Public subnet in Invictus region
resource "google_compute_subnetwork" "public_subnet_invictus" {
  project = var.invictus_project_id
  name = "public-subnet-invictus"
  ip_cidr_range = var.subnet_cidrs["public"]
  network = google_compute_network.main_vpc.id
  region = var.invictus_region
}


# Private subnet for Member 1
resource "google_compute_subnetwork" "member1_private_subnet" {
  provider = google.member1
  project = var.member1_project_id
  name = "member1-private-subnet"
  ip_cidr_range = "10.22.2.0/24"
  network = google_compute_network.member1_vpc.id
  region = var.member1_region
}

# Private subnet for Member 2
resource "google_compute_subnetwork" "member2_private_subnet" {
  provider = google.member2
  project = var.member2_project_id
  name = "member2-private-subnet"
  ip_cidr_range = "10.22.3.0/24"
  network = google_compute_network.member2_vpc.id
  region = var.member2_region
}

# Cloud Router for Member 1 project
resource "google_compute_router" "member1_router" {
  provider = google.member1
  name = "member1-router"
  network = google_compute_network.member1_vpc.id
  region = var.member1_region
}

# Cloud Router for Member 2 project
resource "google_compute_router" "member2_router" {
  provider = google.member2
  name = "member2-router"
  network = google_compute_network.member2_vpc.id
  region = var.member2_region
}

# FFirewall rules (In Invictus project for shared VPC)

# Allow RDP from the internet to the Windows VM
resource "google_compute_firewall" "allow_rdp_public" {
  project = var.invictus_project_id
  name = "allow-rdp-public"
  network = google_compute_network.main_vpc.id

  allow {
    protocol = "tcp"
    ports = ["3389"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["invictus-windows-vm"]
}

# Allow SSH from Windows
resource "google_compute_firewall" "allow_ssh_from_windows" {
  project = var.invictus_project_id
  name = "allow-ssh-from-windows"
  network = google_compute_network.main_vpc.id

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_tags = ["invictus-windows-vm"]
  target_tags = ["member1-linux-vm", "member2-linux-vm"]
}

# # Shared VPC Host Project
# resource "google_compute_shared_vpc_host_project" "host" {
#   project = var.invictus_project_id
# }

# # Shared VPC Service Project
# resource "google_compute_shared_vpc_service_project" "member1" {
#   host_project = var.invictus_project_id
#   service_project = var.member1_project_id
# }

# resource "google_compute_shared_vpc_service_project" "member2" {
#   host_project = var.invictus_project_id
#   service_project = var.member2_project_id
# }

# # IAM Policy to Grant Network User Role to Service Accounts
# resource "google_project_iam_member" "member1_network_user" {
#   project = var.invictus_project_id
#   role = "roles/compute.networkUser"
#   member = "serviceAccount:service-p1-462917-0ee847277508@service-p1-462917.iam.gserviceaccount.com"
# }

# # IAM Policy to Grant Network User Role to Service Accounts
# resource "google_project_iam_member" "member2_network_user" {
#   project = var.invictus_project_id
#   role    = "roles/compute.networkUser"
#   member  = "serviceAccount:service-p2-462917-b22a9e94f9cd@service-p2-462917.iam.gserviceaccount.com"
# }