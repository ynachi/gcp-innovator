module "vpc-host" {
  source                      = "git::https://github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc?ref=v18.0.0"
  project_id                  = var.shared_project_id
  name                        = var.host_network_name
  subnets                     = var.shared_vpc_subnets
  shared_vpc_host             = true
  shared_vpc_service_projects = var.shared_vpc_svc_projects
}
