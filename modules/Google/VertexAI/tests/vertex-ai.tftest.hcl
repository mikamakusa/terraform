run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "dataset" {
    command = apply

    variables {
        dataset = [
            {
                id                    = 0
                display_name          = "terraform"
                metadata_schema_uri   = "gs://google-cloud-aiplatform/schema/dataset/metadata/image_1.0.0.yaml"
                region                = "us-central1"
                labels = {
                    env = "test"
                }
            }
        ]
    }
}

run "deployment_resource_pool" {
    command = apply

    variables {
        region = "us-central-1"
        deployment_resource_pool = [
            {
                id      = 0
                name    = "example-deployment-resource-pool"
                dedicated_resources = [{
                    machine_spec = [{
                        machine_type        = "n1-standard-4"
                        accelerator_type    = "NVIDIA_TESLA_K80"
                        accelerator_count   = 1
                    }]
                    min_replica_count = 1
                    autoscaling_metric_specs = [{
                        metric_name = "aiplatform.googleapis.com/prediction/online/accelerator/duty_cycle"
                    }]
                }]
            }
        ]
    }
}

run "endpoint" {
    command = apply

    variables {
        location = "us-central1"
        region   = "us-central1"
        network = [
            {
                id      = 0
                name    = "vertex_network"
            }
        ]
        compute_global_address = [
            {
                id          = 0
                name        = "vertex_ga"
                network_id  = 0
            }
        ]
        service_networking_connection = [
            {
                id                  = 0
                network_id          = 0
                global_address_id   = 0
            }
        ]
        key_ring = [
            {
                id      = 0
                name    = "vertex_keyring"
            }
        ]
        crypto_key = [
            {
                id          = 0
                key_ring_id = 0
                name        = "vertex_crypto_key"
            }
        ]
        endpoint = [
            {
                id           = 0
                display_name = "sample-endpoint"
                description  = "A sample vertex endpoint"
                labels       = {
                    label-one = "value-one"
                }
                network_id      = 0
                encryption_spec = [{
                    kms_key_id = 0
                }]
            }
        ]
    }
}