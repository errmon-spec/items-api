# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { 'Project 1' }
    owner { association :user }
    token { SecureRandom.hex(20) }
  end
end
