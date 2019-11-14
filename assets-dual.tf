resource "template_dir" "helm-manifests" {
  source_dir      = "${path.module}/resources/helm"
  destination_dir = "${var.asset_dir}/manifests-helm"

  vars = {
    tiller_image = var.container_images["tiller"]

    helm_ca_cert = base64encode(tls_self_signed_cert.helm_ca.cert_pem)
    tiller_cert  = base64encode(tls_locally_signed_cert.tiller.cert_pem)
    tiller_key   = base64encode(tls_private_key.tiller.private_key_pem)
  }
}
