output "service_account_id" {
  value = confluent_service_account.sa.id
}

output "api_key" {
  value     = confluent_api_key.sa_api_key.id
  sensitive = true
}

output "api_secret" {
  value     = confluent_api_key.sa_api_key.secret
  sensitive = true
}
