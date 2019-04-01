variable "cluster_name" {
  description = "Cluster name"
  type        = "string"
}

variable "api_servers" {
  description = "List of URLs used to reach kube-apiserver"
  type        = "list"
}

variable "etcd_servers" {
  description = "List of URLs used to reach etcd servers."
  type        = "list"
}

variable "asset_dir" {
  description = "Path to a directory where generated assets should be placed (contains secrets)"
  type        = "string"
}

variable "cloud_provider" {
  description = "The provider for cloud services (empty string for no provider)"
  type        = "string"
  default     = ""
}

variable "networking" {
  description = "Choice of networking provider (flannel or calico)"
  type        = "string"
  default     = "flannel"
}

variable "network_mtu" {
  description = "CNI interface MTU (applies to calico only)"
  type        = "string"
  default     = "1500"
}

variable "network_ip_autodetection_method" {
  description = "Method to autodetect the host IPv4 address (applies to calico only)"
  type        = "string"
  default     = "first-found"
}

variable "network_ipip_mode" {
  description = "IPIP mode to use (applies to calico only)"
  type        = "string"
  default     = "always"
}

variable "pod_cidr" {
  description = "CIDR IP range to assign Kubernetes pods"
  type        = "string"
  default     = "10.2.0.0/16"
}

variable "service_cidr" {
  description = <<EOD
CIDR IP range to assign Kubernetes services.
The 1st IP will be reserved for kube_apiserver, the 10th IP will be reserved for kube-dns.
EOD

  type    = "string"
  default = "10.3.0.0/24"
}

variable "cluster_domain_suffix" {
  description = "Queries for domains with the suffix will be answered by kube-dns"
  type        = "string"
  default     = "cluster.local"
}

variable "apiserver_vip" {
  description = "VIP to use for apiserver HA via keepalived"
  type        = "string"
  default     = ""
}

variable "container_images" {
  description = "Container images to use"
  type        = "map"

  default = {
    calico           = "quay.io/calico/node:v3.3.1"
    calico_cni       = "quay.io/calico/cni:v3.3.1"
    flannel          = "quay.io/coreos/flannel:v0.10.0-amd64"
    flannel_cni      = "quay.io/coreos/flannel-cni:v0.3.0"
    hyperkube        = "k8s.gcr.io/hyperkube:v1.12.3"
    coredns          = "k8s.gcr.io/coredns:1.2.6"
    pod_checkpointer = "quay.io/coreos/pod-checkpointer:83e25e5968391b9eb342042c435d1b3eeddb2be1"
    keepalived_vip   = "aledbf/kube-keepalived-vip:0.30"
    tiller           = "gcr.io/kubernetes-helm/tiller:v2.13.1"
  }
}

variable "enable_reporting" {
  type = "string"
  description = "Enable usage or analytics reporting to upstream component owners (Tigera: Calico)"
  default = "false"
}

variable "trusted_certs_dir" {
  description = "Path to the directory on cluster nodes where trust TLS certs are kept"
  type        = "string"
  default     = "/usr/share/ca-certificates"
}

variable "ca_certificate" {
  description = "Existing PEM-encoded CA certificate (generated if blank)"
  type        = "string"
  default     = ""
}

variable "ca_key_alg" {
  description = "Algorithm used to generate ca_key (required if ca_cert is specified)"
  type        = "string"
  default     = "RSA"
}

variable "ca_private_key" {
  description = "Existing Certificate Authority private key (required if ca_certificate is set)"
  type        = "string"
  default     = ""
}

variable "apiserver_extra_arguments" {
  description = "List of extra arguments for the kube-apiserver"
  type        = "list"
  default     = []
}

variable "apiserver_extra_secrets" {
  description = "Map of extra data to insert into the kube-apiserver Secrets (values must be BASE64 encoded)"
  type        = "map"
  default     = {}
}

# unofficial, temporary, may be removed without notice

variable "apiserver_port" {
  description = "kube-apiserver port"
  type        = "string"
  default     = "6443"
}
