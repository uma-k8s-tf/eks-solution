locals {
  user_data = <<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BOUNDARY"

--BOUNDARY
Content-Type: application/node.eks.aws

---
apiVersion: node.eks.aws/v1alpha1
kind: NodeConfig
spec:
  cluster:
    apiServerEndpoint: "${data.aws_eks_cluster.eks_cluster.endpoint}"
    certificateAuthority: "${data.aws_eks_cluster.eks_cluster.certificate_authority[0].data}"
    cidr: "${data.aws_eks_cluster.eks_cluster.kubernetes_network_config[0].service_ipv4_cidr}"
    name: "${data.aws_eks_cluster.eks_cluster.name}"

--BOUNDARY
EOF  
}