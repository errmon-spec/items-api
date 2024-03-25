# frozen_string_literal: true

require 'test_helper'

class KeycloakAuthenticationServiceTest < ActiveSupport::TestCase
  test 'creates a new user' do
    keycloak_user = build(:keycloak_user)

    result = KeycloakAuthenticationService.call(keycloak_user)

    assert_predicate result, :success?

    user = result.value!

    assert_equal 'keycloak', user.provider
    assert_equal keycloak_user.id, user.uid
    assert_equal keycloak_user.email, user.email
    assert_equal keycloak_user.profile[:given_name], user.given_name
    assert_equal keycloak_user.profile[:family_name], user.family_name
  end

  test 'updates an existing user' do
    existing_user = create(:user)
    keycloak_user = build(
      :keycloak_user,
      id: existing_user.uid,
      email: 'amelia.lily@errmon.local',
      profile: {
        given_name: 'Amelia',
        family_name: 'Lily',
      },
    )

    result = KeycloakAuthenticationService.call(keycloak_user)

    assert_predicate result, :success?

    user = result.value!

    assert_equal existing_user.reload, user
    assert_equal 'amelia.lily@errmon.local', existing_user.email
    assert_equal 'Amelia', existing_user.given_name
    assert_equal 'Lily', existing_user.family_name
  end
end
