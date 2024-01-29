# frozen_string_literal: true

require 'test_helper'

class ProjectSerializerTest < ActiveSupport::TestCase
  test 'serializes a project' do
    project = build(:project)

    expected = {
      id: project.id,
      owner_id: project.owner_id,
      name: project.name,
      token: project.token,
      created_at: project.created_at,
      updated_at: project.updated_at,
    }

    assert_equal expected, ProjectSerializer.new(project).as_json
  end
end
