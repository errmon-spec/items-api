# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  has_many :project_memberships
  has_many :members, through: :project_memberships, source: :user
  has_many :items

  validates :name, :token, presence: true
end
