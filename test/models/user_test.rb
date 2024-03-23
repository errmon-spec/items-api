# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'validates presence of email' do
    user = User.new

    assert_not user.save
    assert_includes user.errors.messages[:email], "can't be blank"
  end

  test 'validates uniqueness of email' do
    existing_user = create(:user)
    user = User.new(email: existing_user.email)

    assert_not user.save
    assert_includes user.errors.messages[:email], 'has already been taken'
  end

  test 'validates presence of first_name' do
    user = User.new

    assert_not user.save
    assert_includes user.errors.messages[:first_name], "can't be blank"
  end

  test 'validates presence of last_name' do
    user = User.new

    assert_not user.save
    assert_includes user.errors.messages[:last_name], "can't be blank"
  end
end
