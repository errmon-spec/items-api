# frozen_string_literal: true

require 'test_helper'

class KeycloakAuthenticationServiceTest < ActiveSupport::TestCase
  test 'creates a new user from omniauth result if user does not exist' do # rubocop:disable Minitest/MultipleAssertions
    omniauth_result = User::OmniauthResult.new(
      provider: 'test-provider',
      uid: 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11',
      first_name: 'Foo',
      last_name: 'Bar',
      email: 'foo.bar@example.com',
    )

    assert_difference -> { User.count }, 1 do
      user = KeycloakAuthenticationService.call(omniauth_result)

      assert_equal 'test-provider', user.provider
      assert_equal 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', user.uid
      assert_equal 'foo.bar@example.com', user.email
      assert_equal 'Foo', user.first_name
      assert_equal 'Bar', user.last_name
    end
  end

  test 'finds existing user from omniauth result' do
    user = User.create!(
      provider: 'test-provider',
      uid: 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11',
      first_name: 'Foo',
      last_name: 'Bar',
      email: 'foo.bar@example.com',
    )

    assert_no_difference -> { User.count } do
      new_user = KeycloakAuthenticationService.call User::OmniauthResult.new(
        provider: 'test-provider',
        uid: 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11',
        first_name: 'Foo',
        last_name: 'Bar',
        email: 'foo.bar@example.com',
      )

      assert_equal user, new_user
    end
  end
end
