# frozen_string_literal: true

class KeycloakAuthenticationService
  include Dry::Monads[:result]

  def self.call(keycloak_user)
    new(keycloak_user).call
  end

  def initialize(keycloak_user)
    @keycloak_user = keycloak_user
  end

  def call
    scope = User.by_keycloak_id(keycloak_user.id)
    user = scope.take || scope.new

    user.assign_attributes(
      email: keycloak_user.email,
      given_name: keycloak_user.profile.given_name,
      family_name: keycloak_user.profile.family_name,
    )
    user.save! if user.changed?

    Success(user)
  end

  private

  attr_reader :keycloak_user
end
