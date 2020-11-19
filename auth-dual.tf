#
# This renders a special kubeconfig to access the local apiserver directly.
# This is used for health checking purposes.
#
locals {
  auth_kubeconfigs_dual = {
    "auth/kubeconfig-localhost" = data.template_file.kubeconfig-admin-localhost.rendered,
  }
}

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

