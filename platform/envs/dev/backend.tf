terraform {
  backend "gcs" {
    bucket = "tf-buckets-tfstate"
    prefix = "platform/envs/dev"
  }
}