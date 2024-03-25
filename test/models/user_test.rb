# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'validates presence of email' do
    user = User.new

    assert_not user.save
    assert_includes user.errors.messages[:email], 'não pode ficar em branco'
  end

  test 'validates uniqueness of email' do
    existing_user = create(:user)
    user = User.new(email: existing_user.email)

    assert_not user.save
    assert_includes user.errors.messages[:email], 'já está em uso'
  end

  test 'validates presence of given_name' do
    user = User.new

    assert_not user.save
    assert_includes user.errors.messages[:given_name], 'não pode ficar em branco'
  end

  test 'validates presence of family_name' do
    user = User.new

    assert_not user.save
    assert_includes user.errors.messages[:family_name], 'não pode ficar em branco'
  end
end
