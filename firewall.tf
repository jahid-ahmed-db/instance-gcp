resource "google_compute_firewall" "allow_http_fw" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["allow-http-tag"]
}

resource "google_compute_firewall" "allow_https_fw" {
  name    = "allow-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  target_tags = ["allow-https-tag"]
}

resource "google_compute_firewall" "allow_admin_fw" {
  name    = "allow-admin"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["allow-admin-tag"]
}
