# frozen_string_literal: true

class ApplicationSerializer
  def self.serialize_collection(collection)
    collection.map do |item|
      new(item).as_json
    end
  end
end
