# frozen_string_literal: true

source 'https://rubygems.org'

ruby file: File.join(__dir__, '.ruby-version')

gem 'bootsnap', '~> 1.17', require: false
gem 'dry-monads', '~> 1.6'
gem 'dry-struct', '~> 1.6'
gem 'dry-validation', '~> 1.10'
gem 'keycloak-api-rails', '~> 0.12.2'
gem 'msgpack', '~> 1.7'
gem 'oj', '~> 3.16'
gem 'pagy', '~> 7.0'
gem 'pg', '~> 1.5'
gem 'puma', '~> 6.4'
gem 'rack-cors', '~> 2.0'
gem 'rails', '~> 7.1.3'
gem 'sneakers', '~> 2.3'
gem 'ulid', '~> 1.4'

group :test do
  gem 'faker', '~> 3.2'
end

group :development, :test do
  gem 'factory_bot_rails', '~> 6.2'
  gem 'rubocop', '~> 1.62', require: false
  gem 'rubocop-factory_bot', '~> 2.25', require: false
  gem 'rubocop-minitest', '~> 0.35', require: false
  gem 'rubocop-performance', '~> 1.20', require: false
  gem 'rubocop-rails', '~> 2.24', require: false
end
