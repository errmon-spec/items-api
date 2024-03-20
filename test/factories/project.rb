# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    owner { association :user }
    name { Faker::Company.name }
    token { SecureRandom.hex(20) }
  end
end
