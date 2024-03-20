# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby file: File.join(__dir__, '.ruby-version')

gem 'bootsnap', '~> 1.17', require: false
gem 'keycloak-api-rails', '~> 0.12.2'
gem 'msgpack', '~> 1.7'
gem 'oj', '~> 3.16'
gem 'pg', '~> 1.5'
gem 'puma', '~> 6.4'
gem 'rack-cors', '~> 2.0'
gem 'rails', '~> 7.1.3'

group :test do
  gem 'factory_bot_rails', '~> 6.2'
end

group :development, :test do
  gem 'awesome_print', '~> 1.9'
  gem 'debug', '~> 1.9'
  gem 'rubocop', '~> 1.62', require: false
  gem 'rubocop-minitest', '~> 0.35', require: false
  gem 'rubocop-rails', '~> 2.24', require: false
end
