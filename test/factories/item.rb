# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    project
    library { 'errmon.rb' }
    revision { SecureRandom.hex(4) }
    level { 'error' }
    type { 'NoMethodError' }
    message { 'undefined method `foo\' for nil:NilClass' }
    stack_trace { "app/models/user.rb:1:in `foo'" }
  end
end
