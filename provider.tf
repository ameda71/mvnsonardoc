terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.18.0"
    }
  }
}

provider "google" {
  project     = "mythic-guild-452305-m5"
  region      = "us-central1"
  credentials = file("gcp.json")
}
