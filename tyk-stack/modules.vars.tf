variable "opa_enabled" {
  type        = bool
  default     = false
  description = "Enable OPA example in Tyk Dashboard."
}

variable "operator_enabled" {
  type        = bool
  default     = false
  description = "Enable Tyk Operator."
}

variable "datadog_enabled" {
  type        = bool
  default     = false
  description = "Enable DataDog."
}

variable "datadog_api_key" {
  type        = string
  description = "DataDog API key."
}

variable "datadog_site" {
  type        = bool
  default     = "datadoghq.com"
  description = "DataDog site to send analytics to."
}