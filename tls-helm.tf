# ca.crt
resource "local_file" "helm_ca_crt" {
  content  = "${tls_self_signed_cert.helm_ca.cert_pem}"
  filename = "${var.asset_dir}/tls/helm/ca.crt"
}

# client.crt
resource "local_file" "helm_client_crt" {
  content  = "${tls_locally_signed_cert.helm_client.cert_pem}"
  filename = "${var.asset_dir}/tls/helm/client.crt"
}

# client.key
resource "local_file" "helm_client_key" {
  content  = "${tls_private_key.helm_client.private_key_pem}"
  filename = "${var.asset_dir}/tls/helm/client.key"
}

# tiller.crt
resource "local_file" "tiller_crt" {
  content  = "${tls_locally_signed_cert.tiller.cert_pem}"
  filename = "${var.asset_dir}/tls/helm/tiller.crt"
}

# tiller.key
resource "local_file" "tiller_key" {
  content  = "${tls_private_key.tiller.private_key_pem}"
  filename = "${var.asset_dir}/tls/helm/tiller.key"
}

# certificates and keys

resource "tls_private_key" "helm_ca" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_self_signed_cert" "helm_ca" {
  key_algorithm   = "${tls_private_key.helm_ca.algorithm}"
  private_key_pem = "${tls_private_key.helm_ca.private_key_pem}"

  subject {
    common_name  = "helm-ca"
    organization = "helm"
  }

  is_ca_certificate     = true
  validity_period_hours = 175200

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "cert_signing",
  ]
}

resource "tls_private_key" "helm_client" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_cert_request" "helm_client" {
  key_algorithm   = "${tls_private_key.helm_client.algorithm}"
  private_key_pem = "${tls_private_key.helm_client.private_key_pem}"

  subject {
    common_name  = "helm-client"
    organization = "helm"
  }
}

resource "tls_locally_signed_cert" "helm_client" {
  cert_request_pem = "${tls_cert_request.helm_client.cert_request_pem}"

  ca_key_algorithm   = "${join(" ", tls_self_signed_cert.helm_ca.*.key_algorithm)}"
  ca_private_key_pem = "${join(" ", tls_private_key.helm_ca.*.private_key_pem)}"
  ca_cert_pem        = "${join(" ", tls_self_signed_cert.helm_ca.*.cert_pem)}"

  validity_period_hours = 175200

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
  ]
}

resource "tls_private_key" "tiller" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_cert_request" "tiller" {
  key_algorithm   = "${tls_private_key.tiller.algorithm}"
  private_key_pem = "${tls_private_key.tiller.private_key_pem}"

  subject {
    common_name  = "tiller"
    organization = "helm"
  }

  ip_addresses = [
    "127.0.0.1",
  ]

  dns_names = ["${concat(
    var.etcd_servers,
    list(
      "localhost",
    ))}"]
}

resource "tls_locally_signed_cert" "tiller" {
  cert_request_pem = "${tls_cert_request.tiller.cert_request_pem}"

  ca_key_algorithm   = "${join(" ", tls_self_signed_cert.helm_ca.*.key_algorithm)}"
  ca_private_key_pem = "${join(" ", tls_private_key.helm_ca.*.private_key_pem)}"
  ca_cert_pem        = "${join(" ", tls_self_signed_cert.helm_ca.*.cert_pem)}"

  validity_period_hours = 175200

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
  ]
}
