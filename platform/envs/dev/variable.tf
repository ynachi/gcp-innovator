variable "billing_account_id" {
  description = "Billing account to use for this environment"
  type        = string
}

variable "tf_bucket_project" {
  description = "Project used to host terraform buckets"
  type        = string
}