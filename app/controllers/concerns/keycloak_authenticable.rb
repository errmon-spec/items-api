# frozen_string_literal: true

module KeycloakAuthenticable
  extend ActiveSupport::Concern

  included do
    include Keycloak::Authentication

    before_action :keycloak_authenticate
    before_action :authorize_user!
  end

  private

  def append_info_to_payload(payload)
    super
    payload[:user_id] = current_user.uid if user_signed_in?
  end

  def authorize_user!
    head :unauthorized unless user_signed_in?
  end

  def user_signed_in?
    keycloak_user.present? && current_user.present?
  end

  def current_user
    @_current_user ||= KeycloakAuthenticationService.call(keycloak_user).value!
  end

  def keycloak_user(env: request.env)
    return @_keycloak_user if defined?(@_keycloak_user)

    keycloak_token = Keycloak::Helper.keycloak_token(env)
    return if keycloak_token.blank?

    profile = Keycloak::Helper.current_user_custom_attributes(env) || {}

    @_keycloak_user ||= KeycloakUser.new(
      id: Keycloak::Helper.current_user_id(env),
      email: Keycloak::Helper.current_user_email(env),
      profile:,
    )
  end
end
