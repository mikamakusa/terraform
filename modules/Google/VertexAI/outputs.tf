output "vertex_ai_index" {
  value = try(
    google_vertex_ai_index.this.*.id,
    google_vertex_ai_index.this.*.name
  )
}

output "vertex_ai_featurestore" {
  value = try(
    google_vertex_ai_featurestore.this.*.id,
    google_vertex_ai_featurestore.this.*.name
  )
}

output "featurestore_entitytype_feature" {
  value = try(
    google_vertex_ai_featurestore_entitytype_feature.this.*.id,
    google_vertex_ai_featurestore_entitytype_feature.this.*.name
  )
}

output "tensorboard" {
  value = try(
    google_vertex_ai_tensorboard.this.*.id,
    google_vertex_ai_tensorboard.this.*.name,
    google_vertex_ai_tensorboard.this.*.blob_storage_path_prefix
  )
}

output "featurestore_entitytype" {
  value = try(
    google_vertex_ai_featurestore_entitytype.this.*.id,
    google_vertex_ai_featurestore_entitytype.this.*.name
  )
}

output "metadata_store" {
  value = try(
    google_vertex_ai_metadata_store.this.*.id,
    google_vertex_ai_metadata_store.this.*.name
  )
}

output "index_endpoint" {
  value = try(
    google_vertex_ai_index_endpoint.this.*.id,
    google_vertex_ai_index_endpoint.this.*.name
  )
}

output "dataset" {
  value = try(
    google_vertex_ai_dataset.this.*.id,
    google_vertex_ai_dataset.this.*.name
  )
}

output "deployment_resource_pool" {
  value = try(
    google_vertex_ai_deployment_resource_pool.this.*.id,
    google_vertex_ai_deployment_resource_pool.this.*.name
  )
}

output "feature_group" {
  value = try(
    google_vertex_ai_feature_group.this.*.id,
    google_vertex_ai_feature_group.this.*.name
  )
}

output "feature_group_feature" {
  value = try(
    google_vertex_ai_feature_group_feature.this.*.id,
    google_vertex_ai_feature_group_feature.this.*.name
  )
}

output "feature_online_store" {
  value = try(
    google_vertex_ai_feature_online_store.this.*.id,
    google_vertex_ai_feature_online_store.this.*.name
  )
}

output "feature_online_store_featureview" {
  value = try(
    google_vertex_ai_feature_online_store_featureview.this.*.id,
    google_vertex_ai_feature_online_store_featureview.this.*.name
  )
}