output "project" {
  value = try(
    oci_ai_anomaly_detection_project.this
  )
}

output "model" {
  value = try(
    oci_ai_anomaly_detection_model.this
  )
}

output "anomaly_job" {
  value = try(
    oci_ai_anomaly_detection_detect_anomaly_job.this
  )
}

output "data_asset" {
  value = try(
    oci_ai_anomaly_detection_data_asset.this
  )
}