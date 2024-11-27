resource "exoscale_nlb" "public" {
  count = var.enable_public_lb ? 1 : 0

  zone = var.zone
  name = format("%s-nlb-public", var.name)

  description = "Public Network Load Balancer for the `${var.name}` SKS cluster."
  labels = {
    "schtack.cloud" = "true"
    "cluster"       = var.name
    "cluster-id"    = resource.exoscale_sks_cluster.this.id
    "nodepool-id"   = resource.exoscale_sks_nodepool.this[local.public_lb_instance_pool_name].id
  }
}

resource "exoscale_security_group" "public_lb" {
  count = var.enable_public_lb ? 1 : 0

  name        = format("%s-public-lb-sg", var.name)
  description = "Security group for the public NLB of the `${var.name}` SKS cluster."
}

resource "exoscale_security_group_rule" "public_nodeport_tcp_services" {
  count = var.enable_public_lb ? 1 : 0

  security_group_id = resource.exoscale_security_group.public_lb[0].id
  description       = "Allow incoming traffic from any to NodePort TCP services"
  type              = "INGRESS"
  protocol          = "TCP"
  cidr              = "0.0.0.0/0"
  start_port        = 30000
  end_port          = 32767
}

resource "exoscale_security_group_rule" "public_nodeport_udp_services" {
  count = var.enable_public_lb ? 1 : 0

  security_group_id = resource.exoscale_security_group.public_lb[0].id
  description       = "Allow incoming traffic from any to NodePort UDP services"
  type              = "INGRESS"
  protocol          = "UDP"
  cidr              = "0.0.0.0/0"
  start_port        = 30000
  end_port          = 32767
}

resource "exoscale_nlb" "private_lb" {
  count = var.enable_private_lb ? 1 : 0

  zone = var.zone
  name = format("%s-lb-private", var.name)

  description = "Private Load Balancer for the `${var.name}` SKS cluster."
  labels = {
    "schtack.cloud" = "true"
    "cluster"       = var.name
    "cluster-id"    = resource.exoscale_sks_cluster.this.id
    "nodepool-id"   = resource.exoscale_sks_nodepool.this[local.private_lb_instance_pool_name].id
  }
}

resource "exoscale_security_group" "private_lb" {
  count = var.enable_private_lb ? 1 : 0

  name        = format("%s-private-lb-sg", var.name)
  description = "Private security group for the node pool `${local.private_lb_instance_pool_name}` of the `${var.name}` SKS cluster."
}

resource "exoscale_security_group_rule" "private_nodeport_tcp_services" {
  for_each = var.enable_private_lb ? toset(var.private_lb_ip_whitelist) : []

  security_group_id = resource.exoscale_security_group.private_lb[0].id
  description       = "Allow incoming traffic from the private IP whitelist to NodePort TCP services"
  type              = "INGRESS"
  protocol          = "TCP"
  cidr              = each.key
  start_port        = 30000
  end_port          = 32767
}

resource "exoscale_security_group_rule" "private_nodeport_udp_services" {
  for_each = var.enable_private_lb ? toset(var.private_lb_ip_whitelist) : []

  security_group_id = resource.exoscale_security_group.private_lb[0].id
  description       = "Allow incoming traffic from the private IP whitelist to NodePort UDP services"
  type              = "INGRESS"
  protocol          = "UDP"
  cidr              = each.key
  start_port        = 30000
  end_port          = 32767
}
