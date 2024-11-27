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

output "raw_kubeconfig" {
  description = "Raw `.kube/config` file for `kubectl` access."
  value       = resource.exoscale_sks_kubeconfig.this.kubeconfig
  sensitive   = true
}

# TODO Add outputs with the IP addresses of the load balancers, their IDs and their respective node pools.
