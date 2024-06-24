variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster you want to create."
}

variable "cluster_location" {
  type        = string
  default     = "us-west-1"
  description = "EKS cluster location."
}

variable "eks_version" {
  type        = string
  default     = "1.29"
  description = "EKS cluster version."
}

variable "nodes" {
  description = "A list of node configuration for the cluster."
  type = object({})
  default = {
    eks-demo-np = {
      desired_size = 2
      instance_types = ["c5.xlarge"]
      labels = []
    }
  }
}