resource "google_storage_bucket" "nexedge-bucket-prisca" {
  name          = "nexedge-bucket-prisca123"
  location      = "US-CENTRAL1"
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
}
