# frozen_string_literal: true

class Item < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :project
end
