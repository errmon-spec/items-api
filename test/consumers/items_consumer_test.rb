# frozen_string_literal: true

require 'test_helper'

class ItemsConsumerTest < ActiveSupport::TestCase
  test 'calls ItemProcessor#call' do
    consumer = ItemsConsumer.new
    payload = Minitest::Mock.new

    assert_called ItemProcessor, :call, payload, and_return: Success() do
      consumer.work(payload)
    end
  end

  test 'acks when the operation succeeds' do
    consumer = ItemsConsumer.new
    payload = Minitest::Mock.new

    mock_call ItemProcessor, :call, payload, and_return: Success() do
      assert_equal :ack, consumer.work(payload)
    end
  end

  test 'rejects when the operation fails' do
    consumer = ItemsConsumer.new
    payload = Minitest::Mock.new

    mock_call ItemProcessor, :call, payload, and_return: Failure() do
      assert_equal :reject, consumer.work(payload)
    end
  end
end
