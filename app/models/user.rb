# frozen_string_literal: true

class User < ApplicationRecord
  has_many :projects, foreign_key: :owner_id, inverse_of: :owner
  has_many :project_memberships
  has_many :projects_as_member, through: :project_memberships, source: :project

  scope :by_keycloak_id, ->keycloak_id { where(provider: 'keycloak', uid: keycloak_id) }

  validates :email, :given_name, :family_name, presence: true
  validates :email, uniqueness: true
end
