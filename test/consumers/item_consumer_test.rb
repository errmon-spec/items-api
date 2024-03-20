# frozen_string_literal: true

require 'test_helper'

class ItemsConsumerTest < ActiveSupport::TestCase
  test 'calls ItemProcessor#call' do
    consumer = ItemsConsumer.new
    payload = Minitest::Mock.new

    assert_called ItemProcessor, :call, payload do
      consumer.work(payload)
    end
  end
end
