variable "billing_account_id" {
  description = "Billing account to use for this environment"
  type        = string
}

variable "tf_bucket_project" {
  description = "Project used to host terraform buckets"
  type        = string
}

variable "host_network_name" {
  description = "Name of the host shared vpc"
  type        = string
  default     = "shared-vpc"
}

variable "shared_project_id" {
  description = "Shared project ID"
  type        = string
}

variable "shared_vpc_svc_projects" {
  description = "List of service projects ID"
  type        = list(any)
}

variable "shared_vpc_subnets" {
  description = "subnets for the shared vpc"
  type        = list(any)
}

