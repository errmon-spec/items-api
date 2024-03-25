# frozen_string_literal: true

require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  describe 'GET /v1/projects' do
    test 'returns all user projects' do
      user = create(:user)
      projects = create_list(:project, 2, owner: user)

      get v1_projects_path, headers: authorization_headers(user)

      assert_response :success
      assert_equal ProjectSerializer.serialize_collection(projects).to_json, @response.body
    end

    test 'paginates' do
      user = create(:user)
      create_list(:project, 2, owner: user)

      get v1_projects_path, headers: authorization_headers(user)

      assert_equal '1', @response.headers['current-page']
      assert_equal '20', @response.headers['page-items']
      assert_equal '1', @response.headers['total-pages']
      assert_equal '2', @response.headers['total-count']
    end

    test 'fails with authorization error when JWT token is not provided' do
      get v1_projects_path

      assert_response :unauthorized
      assert_equal '{"error":"No JWT token provided"}', @response.body
    end
  end

  describe 'GET /v1/projects/:id' do
    test 'returns an user project' do
      user = create(:user)
      project = create(:project, owner: user)

      get v1_project_path(project), headers: authorization_headers(user)

      assert_response :success
      assert_equal ProjectSerializer.new(project).to_json, @response.body
    end
  end

  describe 'POST /v1/projects' do
    test 'creates an user project' do
      user = create(:user)

      assert_difference -> { user.projects.count } do
        post v1_projects_path,
          headers: authorization_headers(user),
          params: {
            project: {
              name: 'Project 111',
            },
          }
      end

      project = user.projects.last

      assert_response :success
      assert_equal ProjectSerializer.new(project).to_json, @response.body
    end

    test 'publishes an event when a project is created' do
      user = create(:user)

      post v1_projects_path,
        headers: authorization_headers(user),
        params: {
          project: {
            name: 'Project 222',
          },
        }

      project = user.projects.last
      expected_payload = { project_id: project.id, token: project.token }

      assert_published 'project.updated', expected_payload
    end
  end

  describe 'DELETE /v1/projects/:id' do
    test 'deletes the project' do
      user = create(:user)
      project = create(:project, owner: user)

      assert_difference -> { user.projects.count }, -1 do
        delete v1_project_path(project), headers: authorization_headers(user)
      end

      assert_response :success
    end
  end
end
