# frozen_string_literal: true

class ProjectPublisher
  include Dry::Monads[:result]

  class ProjectContract < ApplicationContract
    json do
      required(:project_id).filled(Types::StrippedString)
      required(:token).filled(Types::StrippedString)
    end
  end

  def self.publish(...)
    new(...).publish
  end

  def initialize(project_id:, token:, contract: ProjectContract)
    @project_id = project_id
    @token = token
    @contract = contract
  end

  def publish
    payload = contract.call(project_id:, token:)
    return Failure(payload) if payload.failure?

    RabbitPublisher.publish('project.updated', payload.to_h)

    Success(payload)
  end

  private

  attr_reader :project_id, :token, :contract
end
