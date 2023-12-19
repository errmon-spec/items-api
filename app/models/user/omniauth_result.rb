# frozen_string_literal: true

class User
  OmniauthResult = Data.define(:provider, :uid, :email, :first_name, :last_name)
end
