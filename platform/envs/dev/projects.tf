
locals {
  project_list = { for params in yamldecode(file("vars/projects.yaml"))["projects"] : params["name"] => params }

  # Create a list of service accounts. Need to form a map when want to loop over it to create all the service
  # accounts per project
  sa_list = flatten([
    for project_name, project in local.project_list : [
      for sa in project.service_accounts : {
        sa_project_name = project_name
        sa_name         = sa.name
        sa_display_name = sa.display_name
        sa_generate_key = sa.generate_key
        sa_iam_roles    = sa.iam_roles
      }
    ]
  ])
}

module "project" {
  for_each        = local.project_list
  source          = "git::https://github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/project?ref=v18.0.0"
  billing_account = var.billing_account_id
  name            = each.value.name
  parent          = each.value.parent
  services        = each.value.services
  iam_additive    = each.value.iam_additive
  group_iam       = each.value.group_iam
}

module "prj-service-accounts" {
  for_each     = { for sa in local.sa_list : "${sa.sa_project_name}.${sa.sa_name}" => sa }
  source       = "git::https://github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/iam-service-account?ref=v18.0.0"
  project_id   = each.value.sa_project_name
  name         = each.value.sa_name
  display_name = "Terraform managed ${each.value.sa_display_name}"
  generate_key = each.value.sa_generate_key
  # authoritative roles granted *on* the service accounts to other identities
  iam_project_roles = {
    "myproject" = [
      "roles/logging.logWriter",
      "roles/monitoring.metricWriter",
    ]
  }
}

module "bucket" {
  for_each      = local.project_list
  source        = "git::https://github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gcs?ref=v18.0.0"
  project_id    = var.tf_bucket_project
  name          = each.value.name
  location      = "US" # we only want US
  storage_class = "STANDARD"
  iam = {
    "roles/storage.admin" = ["serviceAccount:sa-cicd@${each.value.name}.iam.gserviceaccount.com"]
  }
}
