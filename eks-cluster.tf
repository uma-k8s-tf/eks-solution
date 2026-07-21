resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_master_role.arn
  version = var.cluster_version
  vpc_config {
    subnet_ids = var.subnet_ids
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_endpoint_public_access_cidrs 
  }
   
  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKSVPCResourceController
  ]
}
data "aws_eks_cluster" "eks" {
  name = aws_eks_cluster.eks_cluster.name

  depends_on = [aws_eks_cluster.eks_cluster]
}

resource "kubernetes_config_map_v1" "aws_auth" {
  depends_on = [aws_eks_cluster.eks_cluster]

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapUsers = yamlencode([
      {
        userarn  = "arn:aws:iam::228228360647:user/Uma"
        username = "admin"
        groups   = ["system:masters"]
      }
    ])
     
    mapRoles = yamlencode([
      {
        rolearn  = aws_iam_role.eks_node_role.arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes"]
      }
    ])
  }
}
  


