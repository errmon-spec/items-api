# frozen_string_literal: true

class ItemsConsumer
  include Sneakers::Worker

  from_queue :items,
    routing_key: 'item.reported',
    content_type: 'application/json',
    timeout_job_after: 10.seconds.in_milliseconds,
    retry_timeout: 5.seconds.in_milliseconds,
    retry_max_times: 10

  def work(payload)
    result = ItemProcessor.call(payload)
    return reject! if result.failure?

    ack!
  end
end
