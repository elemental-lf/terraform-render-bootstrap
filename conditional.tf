# Assets generated only when certain options are chosen

resource "template_dir" "flannel-manifests" {
  count           = "${var.networking == "flannel" ? 1 : 0}"
  source_dir      = "${path.module}/resources/flannel"
  destination_dir = "${var.asset_dir}/manifests-networking"

  vars {
    flannel_image     = "${var.container_images["flannel"]}"
    flannel_cni_image = "${var.container_images["flannel_cni"]}"

    pod_cidr = "${var.pod_cidr}"
  }
}

resource "template_dir" "calico-manifests" {
  count           = "${var.networking == "calico" ? 1 : 0}"
  source_dir      = "${path.module}/resources/calico"
  destination_dir = "${var.asset_dir}/manifests-networking"

  vars {
    calico_image     = "${var.container_images["calico"]}"
    calico_cni_image = "${var.container_images["calico_cni"]}"

    network_mtu                     = "${var.network_mtu}"
    network_ip_autodetection_method = "${var.network_ip_autodetection_method}"
    network_ipip_mode               = "${var.network_ipip_mode}"
    pod_cidr                        = "${var.pod_cidr}"
    enable_reporting                = "${var.enable_reporting}"
  }
}

resource "template_dir" "apiserver-vip-manifests" {
  count           = "${var.apiserver_vip != "" ? 1 : 0}"
  source_dir      = "${path.module}/resources/apiserver-vip"
  destination_dir = "${var.asset_dir}/manifests-apiserver-vip"

  vars {
    apiserver_vip  = "${var.apiserver_vip}"
    apiserver_port = "${var.apiserver_port}"

    keepalived_vip_image = "${var.container_images["keepalived_vip"]}"
  }
}
