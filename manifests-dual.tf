locals {
  helm_manifests = {
  for name in fileset("${path.module}/resources/helm", "**/*.yaml") :
  "manifests/${name}" => templatefile(
  "${path.module}/resources/helm/${name}",
  {
    tiller_image = var.container_images["tiller"]

    helm_ca_cert = base64encode(tls_self_signed_cert.helm_ca.cert_pem)
    tiller_cert  = base64encode(tls_locally_signed_cert.tiller.cert_pem)
    tiller_key   = base64encode(tls_private_key.tiller.private_key_pem)
  }
  )
  }

  extra_assert_apiserver_vip = {
  for name in fileset("${path.module}/resources/apiserver-vip", "**/*.{conf,sh}") :
  "extra-assets/apiserver-vip/${name}" => templatefile(
  "${path.module}/resources/apiserver-vip/${name}",
  {
    apiserver_vip = var.apiserver_vip
    apiserver_vip_interface = var.apiserver_vip_interface
    apiserver_vip_vrrp_id = var.apiserver_vip_vrrp_id
  }
  )
  }
}

resource "local_file" "helm-manifests" {
  for_each = var.asset_dir == "" ? {} : local.helm_manifests

  content  = each.value
  filename = "${var.asset_dir}/${each.key}"
}

resource "local_file" "extra-assets-apiserver-vip" {
  for_each = var.asset_dir == "" ? {} : local.extra_assert_apiserver_vip

  content  = each.value
  filename = "${var.asset_dir}/${each.key}"
}
