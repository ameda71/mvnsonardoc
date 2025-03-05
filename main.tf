provider "google" {
  project     = "mythic-guild-452305-m5"
  region      = "us-central1"
  }

resource "google_compute_instance" "centos_vm" {
  count        = 3  # Create 3 VMs
  name         = "centos9-vm-${count.index}"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "centos-stream-9"
      size  = 20
    }
  }

  network_interface {
    network = "default"
    access_config {}  # Assigns an external IP
  }
}
