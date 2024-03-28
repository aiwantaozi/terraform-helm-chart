resource "random_string" "name_suffix" {
  length  = 10
  special = false
  upper   = false
}

locals {
  project_name     = coalesce(try(var.context["project"]["name"], null), "default")
  project_id       = coalesce(try(var.context["project"]["id"], null), "default_id")
  environment_name = coalesce(try(var.context["environment"]["name"], null), "test")
  environment_id   = coalesce(try(var.context["environment"]["id"], null), "test_id")
  resource_name    = coalesce(try(var.context["resource"]["name"], null), "example")
  resource_id      = coalesce(try(var.context["resource"]["id"], null), "example_id")

  namespace = join("-", [
    local.project_name, local.environment_name
  ])

  name = join("-", [local.resource_name, random_string.name_suffix.result])
}

resource "helm_release" "service" {
  namespace = local.namespace
  name      = local.name
  wait      = false

  repository = var.chart_repository
  chart      = local.chart
  version    = var.chart_version

  values = [
    yamlencode(var.values),
  ]
}

locals {
  chart = coalesce(var.chart_url, var.chart_name)
}
