# frozen_string_literal: true

class ItemSerializer < ApplicationSerializer
  def initialize(item)
    @item = item
    super
  end

  def as_json
    {
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
  end

  private

  attr_reader :item
end
