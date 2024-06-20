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

variable "cp_mdcb_connection_string" {
  type        = string
  default     = "mdcb-svc-tyk-tyk-mdcb.tyk.svc:9091"
  description = "The Control Plane MDCB component host:port."
}

variable "cp_mdcb_ssl_skip_verify" {
  type        = bool
  default     = true
  description = "Skip verifying the Control Plane MDCB component TLS cert (eg. when self-generated and not trusted)."
}

variable "cp_mdcb_use_ssl" {
  type        = bool
  default     = true
  description = "Use SSL for MDCB connection."
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