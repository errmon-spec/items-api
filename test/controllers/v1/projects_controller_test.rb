# frozen_string_literal: true

require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  test 'returns all user projects' do
    user = create(:user)
    projects = create_list(:project, 2, owner: user)

    get v1_projects_path, headers: authorization_headers(user)

    assert_response :success
    assert_equal ProjectSerializer.serialize_collection(projects).to_json, @response.body
  end

  test 'returns an user project' do
    user = create(:user)
    project = create(:project, owner: user)

    get v1_project_path(project), headers: authorization_headers(user)

    assert_response :success
    assert_equal ProjectSerializer.new(project).to_json, @response.body
  end

  test 'creates an user project' do
    user = create(:user)

    assert_difference -> { user.projects.count } do
      post v1_projects_path,
        params: {
          project: {
            name: 'Project 1',
          },
        },
        headers: authorization_headers(user)
    end

    project = user.projects.last

    assert_response :success
    assert_equal ProjectSerializer.new(project).to_json, @response.body
  end

  test 'deletes the project' do
    user = create(:user)
    project = create(:project, owner: user)

    assert_difference -> { user.projects.count }, -1 do
      delete v1_project_path(project), headers: authorization_headers(user)
    end

    assert_response :success
  end
end
