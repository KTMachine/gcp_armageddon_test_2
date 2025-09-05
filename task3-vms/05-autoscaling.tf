# Health check for autoscaler
resource "google_compute_health_check" "autoscaler_health_check" {
  provider = google.member1
  project = var.member1_project_id
  name = "autoscaler-health-check"

  http_health_check {
    port = 80
  }

  check_interval_sec = 5
  timeout_sec = 5
  healthy_threshold = 2
  unhealthy_threshold = 3
}

# Instance template for autoscaling
resource "google_compute_instance_template" "linux_template" {
  provider = google.member1
  name_prefix = "linux-template"
  machine_type = var.linux_vm_configs["member1"].machine_type
  tags = ["autoscaled-linux-vm"]

  disk {
    source_image = var.linux_vm_configs["member1"].disk_image
  }

  network_interface {
    subnetwork = google_compute_subnetwork.member1_private_subnet.id
  }

  metadata = {
    startup-script = <<-EOF
      #!/bin/bash
      apt-get update
      apt-get install -y nginx
      echo "<h1>Hello from autoscaled instance in $Invictus Inc.</h1>" > /var/www/html/index.html
      systemctl restart nginx
    EOF
  }

  lifecycle {
    create_before_destroy = true
  }
}



# Instance group manager for autoscaling
resource "google_compute_instance_group_manager" "member1_autoscaler" {
  provider = google.member1
  name = "member1-autoscaler"
  base_instance_name = "autoscaled-linux-vm"
  zone = var.linux_vm_configs["member1"].zone
  target_size = var.autoscaler_config.min_replicas

  version {
    instance_template = google_compute_instance_template.linux_template.id
  }

  auto_healing_policies {
    health_check = google_compute_health_check.autoscaler_health_check.id
    initial_delay_sec = 300
  }
}

# Autoscaler for Member 1
resource "google_compute_autoscaler" "member1_autoscaler" {
  provider = google.member1
  name = "member1-autoscaler"
  zone = var.linux_vm_configs["member1"].zone
  target = google_compute_instance_group_manager.member1_autoscaler.id

  autoscaling_policy {
    max_replicas = var.autoscaler_config.max_replicas
    min_replicas = var.autoscaler_config.min_replicas
    cooldown_period = var.autoscaler_config.cooldown_period

    cpu_utilization {
      target = var.autoscaler_config.target_cpu_utilization
    }
  }
}