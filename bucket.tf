resource "google_storage_bucket" "nexedge-bucket-prisca" {
  name          = "nexedge-bucket-prisca123"
  location      = "US-CENTRAL1"
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "nexedge-bucket-prisca456" {
  name          = "nexedge-bucket-prisca456"
  location      = "EUROPE-WEST1"
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "nexedge-bucket-prisca789" {
  name          = "nexedge-bucket-prisca789"
  location      = "EUROPE-WEST6"
  storage_class = "STANDARD"
  uniform_bucket_level_access = true     
}
