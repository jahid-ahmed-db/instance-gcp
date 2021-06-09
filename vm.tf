# Request a static IP
resource "google_compute_address" "static" {
  name = "my-ipv4-address"
}

# Retrieve OS image
data "google_compute_image" "debian_image" {
  family  = "debian-9"
  project = "debian-cloud"
}

resource "google_compute_instance" "vm" {
  name         = "vm"
  machine_type = var.machine_type
  zone         = var.zone

  can_ip_forward = false
  description    = "Virtual machine"
  tags           = ["allow-http-tag", "allow-https-tag", "allow-admin-tag"] #Firewall tags

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian_image.self_link
      size  = "40" # Gb
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address #Reference to static IP resource IP address https://www.terraform.io/docs/providers/google/r/compute_address.html#address
    }
  }

  allow_stopping_for_update = true
  
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-rw"]
  }

  metadata_startup_script = file("bootstrap.sh")

  metadata = {
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }

  depends_on = [google_compute_address.static]

}
