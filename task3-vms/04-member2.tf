# Get available zones for Member 2 region
data "google_compute_zones" "member2_available" {
  provider = google.member2
  region = var.member2_region
  status = "UP"
}

# Linux VM for Member 2
resource "google_compute_instance" "member2_linux_vm" {
  provider = google.member2
  name = "member-linux-vm"
  machine_type = var.linux_vm_configs["member2"].machine_type
  zone = var.linux_vm_configs["member2"].zone
  tags = ["member2-linux-vm"]

  boot_disk {
    initialize_params {
      image = var.linux_vm_configs["member2"].disk_image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.member2_private_subnet.id
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}