terraform {
    required_providers {
      google = {
        source  = "hashicorp/google"
        version = "~> 4.0"
      }
    }
}

# The Authentication for the Primary GCP account
provider "google" {
  project = var.invictus_project_id
  region = "us-central1"
  credentials = "invictus-65-68db3f022f9f.json"
}

provider "google" {
  alias = "member1"
  project = var.member1_project_id
  region = "europe-west1"
  credentials = "service-p1-462917-0ee847277508.json"
}

provider "google" {
  alias = "member2"
  project = var.member2_project_id
  region = "asia-southeast1"
  credentials = "service-p2-462917-b22a9e94f9cd.json"
}