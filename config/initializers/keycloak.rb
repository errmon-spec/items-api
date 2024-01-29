# frozen_string_literal: true

Keycloak.configure do |config|
  config.server_url = ENV.fetch('KEYCLOAK_APP_URL', 'http://keycloak:8080')
  config.realm_id = ENV.fetch('KEYCLOAK_REALM', 'errmon')
  config.logger = Rails.logger
  config.opt_in = false
  config.custom_attributes = %w[given_name family_name]
end
