# frozen_string_literal: true

Keycloak.configure do |config|
  config.server_url = Rails.application.credentials.keycloak&.server_url
  config.realm_id = Rails.application.credentials.keycloak&.realm
  config.logger = SemanticLogger[Keycloak]
  config.opt_in = true
  config.custom_attributes = %w[given_name family_name]
end
