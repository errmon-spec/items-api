# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    given_name { Faker::Name.first_name }
    family_name { Faker::Name.last_name }
    email { Faker::Internet.email(name: "#{given_name} #{family_name}", separators: ['-']) }
    provider { 'keycloak' }
    uid { SecureRandom.uuid }
  end
end
