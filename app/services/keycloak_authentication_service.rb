# frozen_string_literal: true

class KeycloakAuthenticationService
  def self.call(omniauth_result)
    new(omniauth_result).call
  end

  def initialize(omniauth_result)
    @omniauth_result = omniauth_result
  end

  def call
    User.find_or_create_by!(provider: omniauth_result.provider, uid: omniauth_result.uid) do |user|
      user.first_name = omniauth_result.first_name
      user.last_name = omniauth_result.last_name
      user.email = omniauth_result.email
    end
  end

  private

  attr_reader :omniauth_result
end
