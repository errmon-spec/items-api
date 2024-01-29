# frozen_string_literal: true

require 'test_helper'

class CreateProjectServiceTest < ActiveSupport::TestCase
  test 'creates a project' do
    user = create(:user)

    project = CreateProjectService.call(user:, name: 'Test Project')

    assert_equal 'Test Project', project.name
    assert_equal user, project.owner
    assert_not_nil project.token
  end
end
