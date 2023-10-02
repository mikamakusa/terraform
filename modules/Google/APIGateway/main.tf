resource "google_api_gateway_api" "this" {
  for_each = var.api_gateway
  provider = google-beta
  project  = data.google_project.this.id
  api_id   = each.key
  labels   = {}
}

resource "google_api_gateway_api_iam_binding" "this" {
  project  = data.google_project.this.id
  provider = google-beta
  api      = google_api_gateway_api.this.api_id
  members  = [var.members]
  role     = "roles/apigateway.viewer"
}

resource "google_api_gateway_api_config" "this" {
  for_each      = var.api_gateway
  project       = data.google_project.this.id
  provider      = google-beta
  api           = google_api_gateway_api.this.api_id
  api_config_id = join("-", [each.key, "config"])

  dynamic "gateway_config" {
    for_each = var.gateway_config == null ? [] : [""]
    content {
      backend_config {
        google_service_account = var.gateway_config
      }
    }
  }

  dynamic "openapi_documents" {
    for_each = var.openapi_documents
    content {
      document {
        contents = filebase64(openapi_documents.value.contents)
        path     = openapi_documents.value.path
      }
    }
  }

  dynamic "grpc_services" {
    for_each = var.grpc_services
    content {
      dynamic "file_descriptor_set" {
        for_each = grpc_services.value.file_descriptor_set
        content {
          contents = filebase64(file_descriptor_set.value.contents)
          path     = file_descriptor_set.value.path
        }
      }
      dynamic "source" {
        for_each = grpc_services.value.source
        content {
          contents = filebase64(source.value.contents)
          path     = source.value.path
        }
      }
    }
  }
}

resource "google_api_gateway_api_config_iam_binding" "this" {
  provider   = google-beta
  project    = data.google_project.this.id
  api        = google_api_gateway_api.this.api_id
  api_config = google_api_gateway_api_config.this.api_config_id
  members    = [var.members]
  role       = "roles/apigateway.viewer"
}

resource "google_api_gateway_gateway" "this" {
  for_each   = var.api_gateway
  project    = data.google_project.this.id
  provider   = google-beta
  api_config = google_api_gateway_api_config.this.id
  gateway_id = join("-", [each.key, "gateway"])
  region     = var.region
}

resource "google_api_gateway_gateway_iam_binding" "this" {
  provider = google-beta
  project  = data.google_project.this.id
  gateway  = google_api_gateway_gateway.this.gateway_id
  members  = [var.members]
  role     = "roles/apigateway.viewer"
}