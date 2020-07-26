locals {
  namespace = "charla"
  stage     = "dev"
  project   = "example"
  canonical_id = "099720109477"
}

module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=master"
  namespace  = local.namespace
  stage      = local.stage
  name       = local.project
  delimiter  = "-"

  tags = {
    "ManagedBy" = "Terraform",
  }
}
