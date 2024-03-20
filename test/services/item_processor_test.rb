# frozen_string_literal: true

require 'test_helper'

class ItemProcessorTest < ActiveSupport::TestCase
  test 'creates an item from the event data' do # rubocop:disable Minitest/MultipleAssertions
    project = create(:project)
    payload = {
      project_id: project.id,
      data: {
        library: 'errmon.js',
        revision: 'v1.0.0',
        level: 'error',
        type: 'NoMethodError',
        message: 'undefined method `foo\' for nil:NilClass',
        stack_trace: 'app/models/user.rb:1:in `foo\'',
      },
    }

    result = ItemProcessor.call(payload)

    assert_predicate result, :success?

    item = result.value!

    assert_equal 'errmon.js', item.library
    assert_equal 'v1.0.0', item.revision
    assert_equal 'error', item.level
    assert_equal 'NoMethodError', item.type
    assert_equal 'undefined method `foo\' for nil:NilClass', item.message
    assert_equal 'app/models/user.rb:1:in `foo\'', item.stack_trace
  end
end
