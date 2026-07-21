
# data "aws_subnet" "selected" {
#   id = var.subnet_ids[0]
# }

# resource "helm_release" "alb_controller" {
  
#   name       = "aws-load-balancer-controller"
#   repository = "https://aws.github.io/eks-charts"
#   chart      = "aws-load-balancer-controller"
#   namespace  = "kube-system"

#   depends_on = [
#     aws_eks_node_group.node_group,
#     kubernetes_service_account_v1.alb_ingress_controller,
#     aws_iam_role_policy_attachment.alb_controller_AmazonEKSLoadBalancerControllerPolicy
#   ]

#   set {
#     name  = "clusterName"
#     value = var.cluster_name
#   }

#   set {
#     name  = "region"
#     value = var.aws_region
#   }

#   set {
#     name  = "vpcId"
#     value = data.aws_subnet.selected.vpc_id
#   }

#   # IMPORTANT: using your custom service account
#   set {
#     name  = "serviceAccount.create"
#     value = "false"
#   }

#   set {
#     name  = "serviceAccount.name"
#     value = "aws-load-balancer-controller"
#   }
# }

