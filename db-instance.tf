resource "google_sql_database_instance" "mysql_db" {
  name             = "mysql-db"
  database_version = "MYSQL_8_0"
  region           = "us-central1"

  settings {
    tier = "db-f1-micro"
  }

  deletion_protection = false
}

resource "google_sql_database_instance" "mysql_db2" {
  name             = "mysql-db2"
  database_version = "MYSQL_8_0"
  region           = "europe-west1"

  settings {
    tier = "db-f1-micro"
  }

  deletion_protection = false
}

resource "google_sql_database_instance" "pgsql_db" {
  name             = "pgsql-db"
  database_version = "POSTGRES_15"
  region           = "europe-west6"

  settings {
    tier = "db-f1-micro"
  }

  deletion_protection = false
}