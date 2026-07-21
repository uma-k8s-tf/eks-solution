# resource "aws_iam_role" "alb_controller" {
#   name = "${var.cluster_name}-alb-controller"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect = "Allow",
#       Principal = {
#         Federated = aws_iam_openid_connect_provider.eks.arn
#       },
#       Action = "sts:AssumeRoleWithWebIdentity",
      
      
# Condition = {
#           StringEquals = merge(
#             {
#               "${local.oidc_url}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
#             },
#             {
#               "${local.oidc_url}:aud" = "sts.amazonaws.com"
#             }
#           )
#         }



#     }]
#   })
# }

# resource "aws_iam_role_policy_attachment" "alb_controller_AmazonEKSLoadBalancerControllerPolicy" {
#   role       = aws_iam_role.alb_controller.name
#   policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
# }
