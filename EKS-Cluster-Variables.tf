# EKS Cluster Input Variables
variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  type        = string
  default     = "eksdemo"
}
variable "aws_region" {
  description = "AWS region where the EKS cluster will be created."
  type        = string
  default     = "ap-southeast-2"
}

variable "subnet_ids" {
  description = "List of subnet IDs to attach the EKS cluster to."
  type        = list(string)
  default     = []
}

variable "cluster_service_ipv4_cidr" {
  description = "service ipv4 cidr for the kubernetes cluster"
  type        = string
  default     = null
}

variable "cluster_version" {
  description = "Kubernetes minor version to use for the EKS cluster (for example 1.21)"
  type = string
  default     = "1.35"
}
variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. When it's set to `false` ensure to have a proper private access with `cluster_endpoint_private_access = true`."
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "name" {
  description = "Optional base name for EKS resources. If not set, cluster_name is used."
  type        = string
  default     = null
}

variable "ssh_key_name" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD4boOmjaeREs7gLPJAfey6F8UkkzyzEvCjHWcliwXu24xOJhMCO+p+dWyR8onYCJ37Tc8RY5HmaxggVl9YtO99vtJ8024I19grxgGUrN+Nk3GPkLVxgdeFXCJ0nmVr/+BXZQv139xZMpwkzO5pYZQCOpbLA4o7fQRB1vpYR+SSKSA82alzKgAVUiwbA4rrixo9oZ4XZput3ttun+iN9xOY+BFOLDFqj03cghfJaiob0WWQV8xSALXuar/c7DXVqubEFgAd89ZAzIePUFvJZeEn5d7gFeuuFHqQ2EOKANdzhvvvXC6jAuAab9dQCKIvdIS3jZ2dHvfKwnE6nA/1bu/N"
}

