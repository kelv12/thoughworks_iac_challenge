terraform {
  backend "gcs" {
    bucket = "abel-bucket"
    prefix = "tfstate/gke"
  }
}
