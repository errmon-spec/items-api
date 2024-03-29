# frozen_string_literal: true

module Types
  include Dry::Types()

  StrippedString = Types::String.constructor(&:strip)
  StringPresence = Types::String.constructor { |string| string.strip.presence }
end
