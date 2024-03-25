# frozen_string_literal: true

FactoryBot.define do
  factory :keycloak_user do
    id { SecureRandom.uuid }
    email { Faker::Internet.email(name: "#{profile[:given_name]} #{profile[:family_name]}", separators: ['-']) }
    profile do
      {
        given_name: Faker::Name.first_name,
        family_name: Faker::Name.last_name,
      }
    end

    initialize_with { new(**attributes) }
  end
end
