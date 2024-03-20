# frozen_string_literal: true

Keycloak.configure do |config|
  config.server_url = Rails.application.config.keycloak_server_url
  config.realm_id = Rails.application.config.keycloak_realm_id
  config.logger = Rails.logger
  config.opt_in = false
  config.custom_attributes = %w[given_name family_name]
end
