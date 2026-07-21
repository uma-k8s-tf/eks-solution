# resource "kubernetes_namespace" "monitoring" {
#   metadata {
#     name = "monitoring"
#   }
# }
# resource "aws_eks_addon" "ebs_csi" {
#   cluster_name = aws_eks_cluster.eks_cluster.name
#   addon_name   = "aws-ebs-csi-driver"
#   service_account_role_arn = aws_iam_role.ebs_csi.arn
  
# depends_on = [
#     aws_iam_role_policy_attachment.ebs_csi
#   ]

# }
# resource "helm_release" "prometheus" {
#   name       = "kube-prometheus-stack"
#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart      = "kube-prometheus-stack"
#   namespace  = kubernetes_namespace.monitoring.metadata[0].name

#   timeout = 1200
  
# depends_on = [
#     aws_ec2_tag.subnet_elb,
#     aws_ec2_tag.subnet_cluster,
#     helm_release.alb_controller,
#     aws_eks_addon.ebs_csi,
#     aws_eks_node_group.node_group
#   ]


#   values = [
#     file("${path.module}/prometheus-values.yaml")
#   ]
  


# }
