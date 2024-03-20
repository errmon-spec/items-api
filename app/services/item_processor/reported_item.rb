# frozen_string_literal: true

class ItemProcessor
  class ReportedItem < Dry::Struct
    ITEM_LEVELS = %w[
      debug
      info
      warning
      error
      critical
    ].freeze

    private_constant :ITEM_LEVELS

    attribute :project_id, Types::String
    attribute :data do
      attribute :library, Types::String
      attribute :revision, Types::String
      attribute :level, Types::String.constrained(included_in: ITEM_LEVELS)
      attribute :type, Types::String
      attribute :message, Types::String
      attribute :stack_trace, Types::String
    end
  end
end
