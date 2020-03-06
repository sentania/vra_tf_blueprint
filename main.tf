provider "vra" {
  url           = var.url
  refresh_token = var.refresh_token
  insecure= "true"
}

data "vra_project" "this" {
  name = var.project_name
}

resource "vra_deployment" "this" {
  name        = var.deployment_name
  description = "terraform test deployment"

  blueprint_id      = var.blueprint_id
  blueprint_version = var.blueprint_version
  project_id        = data.vra_project.this.id

  expand_resources    = true
  expand_last_request = true
  timeouts {
    create = "60m"
    delete = "2h"
  }
   inputs = {
    flavor = "Standard"
    deploymentTarget = "comp"
  }
}
