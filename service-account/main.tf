terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "~> 2.35.0"
    }
  }
  backend "s3" {
    bucket                      = "terraform-confluent-state"
    key                         = "state/service-account.tfstate"
    region                      = "us-east-1"
    endpoint                    = "http://localhost:4566"
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_credentials_validation = true
    skip_region_validation      = true
    use_path_style              = true
    access_key                  = "test"
    secret_key                  = "test"
  }
}

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

resource "confluent_service_account" "sa" {
  display_name = var.confluent_service_account_name
  description  = "Service Account for ${var.confluent_service_account_name}"
}

resource "confluent_api_key" "sa_api_key" {
  display_name      = "sa-api-key-${var.confluent_service_account_name}"
  description       = "API key for service account ${var.confluent_service_account_name}"
  owner {
    id   = confluent_service_account.sa.id
    api_version = confluent_service_account.sa.api_version
    kind        = confluent_service_account.sa.kind
  }
}