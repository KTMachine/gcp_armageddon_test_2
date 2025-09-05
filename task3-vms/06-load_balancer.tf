# Internal Load Balancer
resource "google_compute_forwarding_rule" "internal_lb" {
  project = var.invictus_project_id
  name = "internal-load-balancer"
  region = var.invictus_region
  load_balancing_scheme = "INTERNAL"
  backend_service = google_compute_region_backend_service.linux_backend.id
  ip_protocol = "TCP"
  ports = ["80"]
  subnetwork = google_compute_subnetwork.public_subnet_invictus.id
}

# Invictus Load Balancer Health Check
resource "google_compute_health_check" "invictus_lb_health_check" {
  project = var.invictus_project_id
  name    = "invictus-lb-health-check"

  http_health_check {
    port = 80
  }

  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3
}

# Backend service
resource "google_compute_region_backend_service" "linux_backend" {
  project = var.invictus_project_id
  name = "linux-backend-service"
  region = var.invictus_region
  health_checks = [google_compute_health_check.invictus_lb_health_check.id]

  backend {
    group = google_compute_instance_group_manager.member1_autoscaler.instance_group
  }
}