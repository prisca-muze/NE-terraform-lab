resource "google_compute_network" "my_vpc" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "my_subnet" {
  name          = "my-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.my_vpc.id
  stack_type    = "IPV4_ONLY"
}

resource "google_compute_subnetwork" "my_subnet2" {
  name          = "my-subnet2"
  ip_cidr_range = "10.0.2.0/24"
  region        = "europe-west1"
  network       = google_compute_network.my_vpc.id
  stack_type    = "IPV4_ONLY"
}

resource "google_compute_subnetwork" "my_subnet3" {
  name          = "my-subnet3"
  ip_cidr_range = "10.0.3.0/24"
  region        = "europe-west6"
  network       = google_compute_network.my_vpc.id
  stack_type    = "IPV4_ONLY"
}

resource "google_compute_firewall" "allow_http_https" {
  name    = "allow-http-https"
  network = google_compute_network.my_vpc.id
  
  # No target_tags or target_service_accounts specified -> applies to all instances in the network
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
  description   = "Allow HTTP and HTTPS traffic to instances on the VPC network."
}

