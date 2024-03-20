# frozen_string_literal: true

require 'test_helper'

class ProjectPublisherTest < ActiveSupport::TestCase
  test 'publishes the event' do
    project_id = ULID.generate
    token = SecureRandom.hex(20)

    expected_payload = { project_id:, token: }

    result = ProjectPublisher.publish(project_id:, token:)

    assert_predicate result, :success?
    assert_published 'project.updated', expected_payload
  end
end
