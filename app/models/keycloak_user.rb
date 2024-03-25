# frozen_string_literal: true

class KeycloakUser < Dry::Struct
  transform_keys(&:to_sym)

  attribute :id, Types::StringPresence
  attribute :email, Types::StringPresence
  attribute :profile do
    attribute :given_name, Types::StringPresence
    attribute :family_name, Types::StringPresence
  end
end
