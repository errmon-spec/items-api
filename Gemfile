# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby file: File.join(__dir__, '.ruby-version')

gem 'bootsnap', '~> 1.17', require: false
gem 'cssbundling-rails', '~> 1.3'
gem 'devise', '~> 4.9'
gem 'hiredis-client', '~> 0.19.0'
gem 'jsbundling-rails', '~> 1.2'
gem 'msgpack', '~> 1.7'
gem 'oj', '~> 3.16'
gem 'omniauth-keycloak', '~> 1.5'
gem 'omniauth-rails_csrf_protection', '~> 1.0'
gem 'pg', '~> 1.5'
gem 'puma', '~> 6.4'
gem 'rails', '~> 7.1.2'
gem 'redis', '~> 5.0'
gem 'sprockets-rails', '~> 3.4'
gem 'stimulus-rails', '~> 1.3'
gem 'turbo-rails', '~> 1.5'

group :test do
  gem 'capybara', '~> 3.39'
  gem 'selenium-webdriver', '~> 4.16'
end

group :development, :test do
  gem 'awesome_print', '~> 1.9'
  gem 'debug', '~> 1.9'
  gem 'rubocop', '~> 1.59', require: false
  gem 'rubocop-minitest', '~> 0.34', require: false
  gem 'rubocop-rails', '~> 2.23', require: false
end
