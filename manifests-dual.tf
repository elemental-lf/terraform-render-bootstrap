locals {
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

