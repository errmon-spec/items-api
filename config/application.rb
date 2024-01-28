# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
# require "active_storage/engine"
require 'action_controller/railtie'
require 'action_mailer/railtie'
# require "action_mailbox/engine"
# require "action_text/engine"
require 'action_view/railtie'
# require 'action_cable/engine'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Errmon
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    config.time_zone = 'Brasilia'

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    ##
    ## Thread Pool
    ##

    config.max_threads = ENV.fetch('RAILS_MAX_THREADS', 5).to_i

    ##
    ## Postgres
    ##

    config.database_url = ENV['DATABASE_URL']
    config.database_statement_timeout = ENV.fetch('DATABASE_STATEMENT_TIMEOUT', '10s')
    config.database_connect_timeout = 1
    config.database_checkout_timeout = 1
    config.database_pool_size = config.max_threads

    config.active_record.db_warnings_action = :report

    ActiveSupport.on_load(:active_record_postgresqladapter) do
      self.datetime_type = :timestamptz
    end

    ##
    ## Logger
    ##

    config.logger = ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new($stdout))
    config.log_level = ENV.fetch('RAILS_LOG_LEVEL', 'info')

    ##
    ## Performance
    ##

    config.action_view.frozen_string_literal = true
    config.active_support.message_serializer = :message_pack
    config.action_dispatch.cookies_serializer = :message_pack
  end
end
