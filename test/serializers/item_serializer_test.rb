# frozen_string_literal: true

require 'test_helper'

class ItemSerializerTest < ActiveSupport::TestCase
  test 'serializes an item' do
    item = create(:item)

    expected = {
      id: item.id,
      project_id: item.project_id,
      library: item.library,
      revision: item.revision,
      status: item.status,
      read: item.read,
      level: item.level,
      type: item.type,
      message: item.message,
      stack_trace: item.stack_trace,
      created_at: item.created_at,
      updated_at: item.updated_at,
    }

    assert_equal expected, ItemSerializer.new(item).as_json
  end
end
