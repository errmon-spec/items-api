# frozen_string_literal: true

class User < ApplicationRecord
  has_many :projects, foreign_key: :owner_id, inverse_of: :owner
  has_many :project_memberships
  has_many :projects_as_member, through: :project_memberships, source: :project

  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: true
end
