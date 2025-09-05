# Project IDs

#Invictus INC GCP Project ID
variable "invictus_project_id" {
  description = "Invictus INC GCP project ID"
  type = string
  default = "invictus-65"
}

# Member 1 GCP Project ID
variable "member1_project_id" {
  description = "Member 1 GCP project ID"
  type = string
  default = "service-p1-462917"
}

# Member 2 GCP Project ID
variable "member2_project_id" {
  description = "Member 2 GCP project ID"
  type = string
  default = "service-p2-462917"
}

# Regions for the Projects
variable "invictus_region" {
  description = "Region for Invictus INC project"
  type = string
  default = "us-central1"
}

variable "member1_region" {
  description = "Region for Member 1 project"
  type = string
  default = "europe-west1"
}

variable "member2_region" {
  description = "Region for Member 2 project"
  type = string
  default = "asia-southeast1"
}

# Windows VM Configuration
variable "windows_vm_config" {
  description = "Configuration for Windows VM"
  type = object ({
    machine_type = string
    disk_image = string
    zone = string
  })
  default = {
    machine_type = "e2-standard-2"
    disk_image = "projects/windows-cloud/global/images/family/windows-2019"
    zone = "us-central1-a"
  }
}

# Linux VM Configurations
variable "linux_vm_configs" {
  description = "Configuration for Linux VMS per member"
  type = map(object({
    machine_type = string
    disk_image = string
    zone = string
  }))
  default = {
    member1 = {
      machine_type = "e2-standard-2"
      disk_image = "ubuntu-2204-jammy-v20230919"
      zone = "europe-west1-b"
    },
    member2 = {
      machine_type = "e2-standard-2"
      disk_image = "ubuntu-2204-jammy-v20230919"
      zone = "asia-southeast1-a"
    }
  }
}

# Autoscaler Configuration 
variable "autoscaler_config" {
  description = "Configurationn for the autoscaler"
  type = object({
    max_replicas = number
    min_replicas = number
    cooldown_period = number
    target_cpu_utilization = number
  })
  default = {
    max_replicas = 4
    min_replicas = 2
    cooldown_period = 60
    target_cpu_utilization = 0.8
  }
}

# Subnet CIDRs
variable "subnet_cidrs" {
  description = "CIDR ranges for each subnet"
  type = map(string)
  default = {
    public = "10.22.1.0/24"
    member1 = "10.22.2.0/24"
    member2 = "10.22.3.0/24"
  }
}