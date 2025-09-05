output "windows_vm_public_ip" {
  value = google_compute_instance.invictus_windows_vm.network_interface[0].access_config[0].nat_ip
  description = "Public IP for RDP access to Windows VM"
}

output "member1_linux_vm_ip" {
  value = google_compute_instance.member1_linux_vm.network_interface[0].network_ip
  description = "Private IP for Member 1 Linux VM"
}

output "member2_linux_vm_ip" {
  value = google_compute_instance.member2_linux_vm.network_interface[0].network_ip
  description = "Private IP of Member Linux VM"
}

output "load_balancer_ip" {
  value = google_compute_forwarding_rule.internal_lb.ip_address
  description = "Internal IP of the load balancer"
}

output "available_zones_member1" {
  value = data.google_compute_zones.member1_available.names
  description = "Available zones in Member 1 region"
}

output "available_zones_member2" {
  value = data.google_compute_zones.member2_available.names
  description = "Available zones in Member 2 region"
}

output "autoscaler_status" {
  value = google_compute_autoscaler.member1_autoscaler.self_link
  description = "Autoscaler resource status"
}