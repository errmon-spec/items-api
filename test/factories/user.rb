# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name  { 'Doe' }
    sequence(:email) { |n| "john.doe#{n}@gmail.com" }
    provider { 'keycloak' }
    uid { SecureRandom.uuid }
  end
end
