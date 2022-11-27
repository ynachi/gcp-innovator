# locals {
#   service_project_1 = {
#     project_id = "project1"
#     gke_service_account = "gke"
#     cloud_services_service_account = "cloudsvc"
#   }
#   service_project_2 = {
#     project_id = "project2"
#   }
# }

# module "vpc-host" {
#   source     = "git::https://github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc?ref=v18.0.0"
#   project_id = "my-project"
#   name       = "my-host-network"
#   subnets = [
#     {
#       ip_cidr_range = "10.0.0.0/24"
#       name          = "subnet-1"
#       region        = "europe-west1"
#       secondary_ip_range = {
#         pods     = "172.16.0.0/20"
#         services = "192.168.0.0/24"
#       }
#     }
#   ]
#   shared_vpc_host = true
#   shared_vpc_service_projects = [
#     local.service_project_1.project_id,
#     local.service_project_2.project_id
#   ]
#   subnet_iam = {
#     "europe-west1/subnet-1" = {
#       "roles/compute.networkUser" = [
#         local.service_project_1.cloud_services_service_account,
#         local.service_project_1.gke_service_account
#       ]
#       "roles/compute.securityAdmin" = [
#         local.service_project_1.gke_service_account
#       ]
#     }
#   }
# }
