# frozen_string_literal: true

require 'test_helper'

class V1::ItemsControllerTest < ActionDispatch::IntegrationTest
  describe 'GET /v1/items' do
    test 'returns items' do
      user = create(:user)
      project = create(:project, owner: user)
      items = create_list(:item, 2, project:)

      get v1_project_items_path(project), headers: authorization_headers(user)

      assert_response :success
      assert_equal ItemSerializer.serialize_collection(items).to_json, @response.body
    end
  end

  describe 'GET /v1/items/:id' do
    test 'returns an item' do
      user = create(:user)
      project = create(:project, owner: user)
      item = create(:item, project:)

      get v1_project_item_path(project, item), headers: authorization_headers(user)

      assert_response :success
      assert_equal ItemSerializer.new(item).to_json, @response.body
    end
  end
end
