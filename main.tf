terraform {
    required_providers {
      google = {
        source = "hashicorp/google"
        version = "~> 5.0"
      }
    }
}

provider "google" {
  project = "ne-project-494917"
  credentials = file("ne-project-494917-346c3ad07dbe.json")
}

