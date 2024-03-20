# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authenticable
  include Pagy::Backend

  prepend_before_action do
    authorize_user!
  end
end
