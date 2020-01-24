output "helm_ca" {
  value     = tls_self_signed_cert.helm_ca.cert_pem
  sensitive = true
}

output "helm_client_key" {
  value     = tls_private_key.helm_client.private_key_pem
  sensitive = true
}

output "helm_client_cert" {
  value     = tls_locally_signed_cert.helm_client.cert_pem
  sensitive = true
}
