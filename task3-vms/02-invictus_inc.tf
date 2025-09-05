# WIndows VM in Invictus project
resource "google_compute_instance" "invictus_windows_vm" {
  project = var.invictus_project_id
  name = "invictus-windows-vm"
  machine_type = var.windows_vm_config.machine_type
  zone = var.windows_vm_config.zone
  tags = ["invictus-windows-vm"]

  boot_disk {
    initialize_params {
      image = var.windows_vm_config.disk_image
    }
  }

  network_interface {
    network = google_compute_network.main_vpc.id
    subnetwork = google_compute_subnetwork.public_subnet_invictus.id
    access_config {}
  }
}