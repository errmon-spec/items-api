# frozen_string_literal: true

class ApplicationController < ActionController::API
  include KeycloakAuthenticable
  include Pagy::Backend
end
