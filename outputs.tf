# NOTE: the outputs in this file are organized in alphabetical order.

output "kubernetes_host" {
  description = "Endpoint for your Kubernetes API server."
  value       = resource.exoscale_sks_cluster.this.endpoint
}

output "kubernetes_cluster_ca_certificate" {
  description = "Certificate Authority required to communicate with the cluster."
  value       = base64decode(local.kubeconfig.clusters.0.cluster.certificate-authority-data)
  sensitive   = true
}

output "kubernetes_client_key" {
  description = "Certificate Client Key required to communicate with the cluster."
  value       = base64decode(local.kubeconfig.users.0.user.client-key-data)
  sensitive   = true
}

output "kubernetes_client_certificate" {
  description = "Certificate Client Certificate required to communicate with the cluster."
  value       = base64decode(local.kubeconfig.users.0.user.client-certificate-data)
  sensitive   = true
}

output "private_lb" {
  description = <<-EOT
    Informations about the private load balancer and the node pool that is used as its backend.
    - `id`: The ID of the private load balancer.
    - `ip_address`: The IP address of the private load balancer.
    - `nodepool_id`: The ID of the node pool that is used as the backend for the private load balancer.
  EOT
  value = var.enable_private_lb ? {
    id                        = resource.exoscale_nlb.private_lb[0].id
    ip_address                = resource.exoscale_nlb.private_lb[0].ip_address
    nodepool_id               = resource.exoscale_sks_nodepool.this[local.private_lb_instance_pool_name].id
    nodepool_instance_pool_id = resource.exoscale_sks_nodepool.this[local.private_lb_instance_pool_name].instance_pool_id
  } : null
}

output "public_lb" {
  description = <<-EOT
    Informations about the public load balancer and the node pool that is used as its backend.
    - `id`: The ID of the public load balancer.
    - `ip_address`: The IP address of the public load balancer.
    - `nodepool_id`: The ID of the node pool that is used as the backend for the public load balancer.
  EOT
  value = var.enable_public_lb ? {
    id                        = resource.exoscale_nlb.public_lb[0].id
    ip_address                = resource.exoscale_nlb.public_lb[0].ip_address
    nodepool_id               = resource.exoscale_sks_nodepool.this[local.public_lb_instance_pool_name].id
    nodepool_instance_pool_id = resource.exoscale_sks_nodepool.this[local.public_lb_instance_pool_name].instance_pool_id

  } : null
}

output "raw_kubeconfig" {
  description = "Raw `.kube/config` file for `kubectl` access."
  value       = resource.exoscale_sks_kubeconfig.this.kubeconfig
  sensitive   = true
}
