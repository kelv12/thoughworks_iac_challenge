terraform {
  backend "gcs" {
    bucket = "abel-bucket"
    prefix = "terraform/state"
  }
}
