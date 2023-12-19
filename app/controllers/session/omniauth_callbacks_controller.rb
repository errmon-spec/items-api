# frozen_string_literal: true

module Session
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token, only: :keycloakopenid

    def keycloakopenid
      omniauth_data = request.env['omniauth.auth']
      omniauth_result = User::OmniauthResult.new(
        provider: omniauth_data.provider,
        uid: omniauth_data.uid,
        email: omniauth_data.info.email,
        first_name: omniauth_data.info.first_name,
        last_name: omniauth_data.info.last_name,
      )
      @user = KeycloakAuthenticationService.call(omniauth_result)
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
      else
        flash[:error] = t('auth.error')
        session['devise.keycloakopenid_data'] = omniauth_data
        redirect_to root_path
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
