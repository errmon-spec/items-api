# frozen_string_literal: true

class KeycloakTestAdapter
  include Singleton

  attr_reader :private_key

  def initialize
    @private_key = OpenSSL::PKey::RSA.generate(1024)
    patch!
  end

  def generate_jwt(user, issued_at: Time.zone.now, expires_at: 1.day.from_now)
    claims = {
      iat: issued_at.to_i,
      exp: expires_at.to_i,
      sub: user.id,
      email: user.email,
      given_name: user.profile.given_name,
      family_name: user.profile.family_name,
    }
    token = JSON::JWT.new(claims)
    token.kid = 'default'
    token.sign(private_key, :RS256).to_s
  end

  private

  def patch!
    Keycloak::PublicKeyCachedResolver.class_eval do
      def find_public_keys
        private_key = KeycloakTestAdapter.instance.private_key
        JSON::JWK::Set.new JSON::JWK.new(private_key, kid: 'default')
      end
    end
  end
end

module KeycloakTestHelpers
  def authorization_headers(user)
    keycloak_user = user.is_a?(KeycloakUser) ? user : user_to_keycloak_user(user)
    jwt = KeycloakTestAdapter.instance.generate_jwt(keycloak_user)

    {
      'HTTP_AUTHORIZATION' => "Bearer #{jwt}",
    }
  end

  def user_to_keycloak_user(user)
    KeycloakUser.new(
      id: user.uid,
      email: user.email,
      profile: {
        given_name: user.given_name,
        family_name: user.family_name,
      },
    )
  end
end

module ActiveSupport
  class TestCase
    include KeycloakTestHelpers
  end
end
