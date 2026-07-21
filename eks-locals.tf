locals {
  name = var.name != null ? var.name : var.cluster_name
}

locals {
  oidc_url = replace(aws_iam_openid_connect_provider.eks.url, "https://", "")
}

