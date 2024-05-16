run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "container_v1" {
  command = apply

  variables {
    metadata = {
      test    = true,
      deploy  = "terraform"
    }
    project = "project_test"
    secret_v1 = [
      {
        id                   = 0
        name                 = "certificate"
        payload              = file("cert.pem")
        secret_type          = "certificate"
        payload_content_type = "text/plain"
      },
      {
        id                   = 1
        name                 = "private_key"
        payload              = file("cert-key.pem")
        secret_type          = "private"
        payload_content_type = "text/plain"
      },
      {
        id                   = 2
        name                 = "intermediate"
        payload              = file("intermediate-ca.pem")
        secret_type          = "certificate"
        payload_content_type = "text/plain"
      }
    ]
    container_v1 = [
      {
        id    = 0
        name  = "tls"
        type  = "certificate"
        secret_refs = [
          {
            name       = "certificate"
            secret_ref = 0
          },
          {
            name       = "private_key"
            secret_ref = 1
          },
          {
            name       = "intermediate"
            secret_ref = 2
          }
        ]
      }
    ]
  }
}

run "order_v1" {
  command = apply

  variables {
    order_v1 = [
      {
        id = 0
        type = "key"
        meta = [
          {
            algorithm  = "aes"
            bit_length = 256
            name       = "mysecret"
            mode       = "cbc"
          }
        ]
      }
    ]
  }
}

run "secret_v1" {
  command = apply

  variables {
    metadata = {
      test    = true,
      deploy  = "terraform"
    }
    project = "project_test"
    secret_v1 = [
      {
        id                   = 0
        name                 = "certificate"
        payload              = file("cert.pem")
        secret_type          = "certificate"
        payload_content_type = "text/plain"
      },
      {
        id                   = 1
        name                 = "private_key"
        payload              = file("cert-key.pem")
        secret_type          = "private"
        payload_content_type = "text/plain"
      },
      {
        id                   = 2
        name                 = "intermediate"
        payload              = file("intermediate-ca.pem")
        secret_type          = "certificate"
        payload_content_type = "text/plain"
      }
    ]
  }
}
