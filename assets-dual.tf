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

resource "template_dir" "extra-assets-apiserver-vip" {
  source_dir      = "${path.module}/resources/apiserver-vip"
  destination_dir = "${var.asset_dir}/extra-assets/apiserver-vip"

  vars = {
    apiserver_vip = var.apiserver_vip
    apiserver_vip_interface = "bond0"
    apiserver_vip_vrrp_id = 178
  }
}

#
# This renders a special kubeconfig to access the local apiserver directly.
# This is used for health checking purposes.
#
data "template_file" "kubeconfig-admin-localhost" {
  template = file("${path.module}/resources/kubeconfig-admin")

  vars = {
    name         = var.cluster_name
    ca_cert      = base64encode(tls_self_signed_cert.kube-ca.cert_pem)
    kubelet_cert = base64encode(tls_locally_signed_cert.admin.cert_pem)
    kubelet_key  = base64encode(tls_private_key.admin.private_key_pem)
    server       = format("https://localhost:%s", var.external_apiserver_port)
  }
}

resource "local_file" "kubeconfig-admin-localhost" {
  content  = data.template_file.kubeconfig-admin-localhost.rendered
  filename = "${var.asset_dir}/auth/kubeconfig-localhost"
}
