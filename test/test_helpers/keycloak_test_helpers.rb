# frozen_string_literal: true

class KeycloakTestAdapter
  include Singleton

  attr_reader :private_key

  def initialize
    @private_key = OpenSSL::PKey::RSA.generate(1024)
    patch!
  end

  def generate_jwt(user = nil)
    claims = {
      iat: Time.zone.now.to_i,
      exp: 1.day.from_now.to_i,
      sub: user&.uid || SecureRandom.uuid,
      given_name: user&.first_name || 'John',
      family_name: user&.last_name || 'Doe',
      email: user&.email || 'john.doe@gmail.com',
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
  def authorization_headers(user = nil)
    jwt = KeycloakTestAdapter.instance.generate_jwt(user)
    {
      'HTTP_AUTHORIZATION' => "Bearer #{jwt}",
    }
  end

  def sign_in_as(user = nil)
    jwt = KeycloakTestAdapter.instance.generate_jwt(user)
    @request.env['HTTP_AUTHORIZATION'] = jwt
  end
end

class ActionDispatch::IntegrationTest # rubocop:disable Style/ClassAndModuleChildren
  include KeycloakTestHelpers
end
