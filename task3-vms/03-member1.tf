# Get available zones for Member 1 region
data "google_compute_zones" "member1_available" {
  provider = google.member1
  region = var.member1_region
  status = "UP"
}

# Linux VM for Member 1
resource "google_compute_instance" "member1_linux_vm" {
  provider = google.member1
  name = "member1-linux-vm"
  machine_type = var.linux_vm_configs["member1"].machine_type
  zone = var.linux_vm_configs["member1"].zone
  tags = ["member-linux-vm"]

  boot_disk {
    initialize_params {
      image = var.linux_vm_configs["member1"].disk_image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.member1_private_subnet.id
  }

  metadata = {
    ssh-key = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}