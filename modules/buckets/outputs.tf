
output "bucket_names" {
  value       = module.gcs_buckets.names
  description = "Bucket names"
}

output "buckets_url" {
  value       = module.gcs_buckets.urls
  description = "Bucket URLS"
}
