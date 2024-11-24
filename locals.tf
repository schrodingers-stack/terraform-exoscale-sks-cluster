locals {
  # Decode the YAML kubeconfig file into a structured value in order to generate separate outputs for each of 
  # its fields.
  kubeconfig = yamldecode(resource.exoscale_sks_kubeconfig.this.kubeconfig)

  # Select the default node pool if the public or private node pool is not defined.
  public_lb_instance_pool_name  = var.public_lb_nodepool != null ? var.public_lb_nodepool : keys(var.nodepools)[0]
  private_lb_instance_pool_name = var.private_lb_nodepool != null ? var.private_lb_nodepool : keys(var.nodepools)[0]
}
