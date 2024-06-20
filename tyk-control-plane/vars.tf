variable "namespace" {
  type        = string
  default     = "tyk"
  description = "Namespace to be created to house Tyk deployment."
}

variable "gateway_version" {
  type        = string
  default     = "v5.3"
  description = "Tyk Gateway container version."
}

variable "dashboard_version" {
  type        = string
  default     = "v5.3"
  description = "Tyk Dashboard container version."
}

variable "pump_version" {
  type        = string
  default     = "v1.9"
  description = "Tyk Pump container version."
}

variable "mdcb_version" {
  type        = string
  default     = "v2.5"
  description = "Tyk MDCB container version."
}

variable "kubernetes_config_path" {
  type        = string
  default     = "~/.kube/config"
  description = "Kubernetes config file path."
}

variable "kubernetes_config_context" {
  type        = string
  default     = "minikube"
  description = "Kubernetes config context."
}