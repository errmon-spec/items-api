# frozen_string_literal: true

class ItemProcessor
  include Dry::Monads[:result]

  def self.call(...)
    new(...).call
  end

  def initialize(payload)
    @item_event = ReportedItem.new(payload)
  end

  def call
    item = project.items.create!(
      library: item_event.data.library,
      revision: item_event.data.revision,
      level: item_event.data.level,
      type: item_event.data.type,
      message: item_event.data.message,
      stack_trace: item_event.data.stack_trace,
    )

    Success(item)
  end

  private

  attr_reader :item_event

  def project
    @_project ||= Project.find(item_event.project_id)
  end
end
