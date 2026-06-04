resource "google_sql_database_instance" "mysql_db" {
  name             = "mysql-db"
  database_version = "MYSQL_8_0"
  region           = "us-central1"

  settings {
    tier = "db-f1-micro"
  }

  deletion_protection = false
}