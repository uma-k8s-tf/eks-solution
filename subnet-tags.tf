resource "aws_ec2_tag" "subnet_elb" {
  for_each = toset(var.subnet_ids)

  resource_id = each.value
  key         = "kubernetes.io/role/elb"
  value       = "1"
}

resource "aws_ec2_tag" "subnet_cluster" {
  for_each = toset(var.subnet_ids)

  resource_id = each.value
  key         = "kubernetes.io/cluster/${var.cluster_name}"
  value       = "shared"
}