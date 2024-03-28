# @label "Source Type"
# @options ["url", "repository"]
variable "source_type" {
  type        = string
  description = "Source type of the chart"
  default     = "repository"
}

# @label "Chart URL"
# @show_if "source_type=url"
variable "chart_url" {
  type        = string
  description = "URL to download the chart"
  default     = ""
}

# @label "Chart Repository"
# @show_if "source_type=repository"
variable "chart_repository" {
  type        = string
  description = "Chart repository. e.g., https://charts.bitnami.com/bitnami or oci://192.168.1.100:5000/helm-charts"
  default     = ""
}

# @label "Chart Name"
# @show_if "source_type=repository"
variable "chart_name" {
  type        = string
  description = "Chart name"
  default     = ""
}

# @label "Chart Version"
# @show_if "source_type=repository"
variable "chart_version" {
  type        = string
  description = "Chart version"
  default     = ""
}

# @label "Set Custom Values"
variable "set_custom_values" {
  type        = bool
  description = "Set custom values"
  default     = false
}

# @label "Values"
# @show_if "set_custom_values=true"
variable "values" {
  type        = any
  description = "Chart values"
  default     = {}
}

variable "context" {
  description = <<-EOF
Receive contextual information. When Walrus deploys, Walrus will inject specific contextual information into this field.

Examples:
```
context:
  project:
    name: string
    id: string
  environment:
    name: string
    id: string
  resource:
    name: string
    id: string
```
EOF
  type        = map(any)
  default     = {}
}
