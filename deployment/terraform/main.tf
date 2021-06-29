// Configure the Google Cloud provider
provider "google" {
  credentials = file("/Users/arihuttunen/google-cloud-secrets/aris-test-project-317919-2231aebd7bf8.json")
  project     = "aris-test-project-317919"
  region      = "europe-north1"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
  byte_length = 8
}

// VM that runs the web server
resource "google_compute_instance" "web_server" {
  name         = "perftest-web-server-vm-${random_id.instance_id.hex}"
  machine_type = "e2-standard-2"
  zone         = "europe-north1-a"

  tags = ["perftest-web-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

}

// VM that runs Goose Attack
resource "google_compute_instance" "geese" {
  name         = "perftest-geese-vm-${random_id.instance_id.hex}"
  machine_type = "e2-standard-2"
  zone         = "europe-north1-a"

  tags = ["perftest-geese"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

}
