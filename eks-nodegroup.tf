data "aws_ssm_parameter" "eks_ami" {
  provider = aws
  name = "/aws/service/eks/optimized-ami/1.35/amazon-linux-2023/x86_64/standard/recommended/image_id"
}

output "eks_ami_id" {
  value = nonsensitive(data.aws_ssm_parameter.eks_ami.value)
}



data "aws_eks_cluster" "eks_cluster" {
  name = aws_eks_cluster.eks_cluster.name
}


resource "aws_key_pair" "eks_key" {
  key_name   = "ec2-key"
  public_key = file("./key.pub")
}

resource "aws_launch_template" "eks_node_lt" {
  name_prefix   = "eks-node-"
  image_id      = data.aws_ssm_parameter.eks_ami.value
  instance_type = "t3.small"
  user_data = base64encode(local.user_data)

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
      volume_type = "gp3"
      delete_on_termination = true
      encrypted = true
    }
    
  }
  # iam_instance_profile {
  #   arn = aws_iam_instance_profile.eks_node.arn
  # }
  
  key_name = aws_key_pair.eks_key.key_name
  
  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
    http_put_response_hop_limit = 2
  }
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "eks-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids = var.subnet_ids

  timeouts {
    create = "10m"
  }
  
  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  capacity_type = "ON_DEMAND"

  launch_template {
    id      = aws_launch_template.eks_node_lt.id
    version = aws_launch_template.eks_node_lt.latest_version
  }

  depends_on = [
    aws_iam_role_policy_attachment.worker_node_policy,
    aws_iam_role_policy_attachment.cni_policy,
    aws_iam_role_policy_attachment.container_registry,
    aws_iam_role_policy_attachment.SSMCore
  ]
}