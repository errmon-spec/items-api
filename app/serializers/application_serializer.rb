# frozen_string_literal: true

module ApplicationSerializer
  module ClassMethods
    def serialize_collection(collection)
      collection.map do |item|
        new(item).as_json
      end
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end
end
