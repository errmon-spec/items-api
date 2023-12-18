# frozen_string_literal: true

if Rails.env.development? && defined?(RubyLsp::Rails)
  Rails.application.configure do
    config.ruby_lsp_rails.server = false
  end
end
