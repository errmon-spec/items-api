# frozen_string_literal: true

module Authenticable
  extend ActiveSupport::Concern

  def current_user
    @_current_user ||= begin
      attributes = Keycloak::Helper.current_user_custom_attributes(request.env)
      omniauth_result = User::OmniauthResult.new(
        provider: 'keycloak',
        uid: Keycloak::Helper.current_user_id(request.env),
        email: Keycloak::Helper.current_user_email(request.env),
        first_name: attributes['given_name'],
        last_name: attributes['family_name'],
      )
      KeycloakAuthenticationService.call(omniauth_result)
    end
  end

  def user_signed_in?
    current_user.present?
  end

  def authorize_user!
    head :unauthorized unless user_signed_in?
  end
end
