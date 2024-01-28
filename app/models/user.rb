# frozen_string_literal: true

class User < ApplicationRecord
  has_many :projects, foreign_key: :owner_id, inverse_of: :owner
  has_many :project_memberships
  has_many :projects_as_member, through: :project_memberships, source: :project

  devise :omniauthable, omniauth_providers: %i[keycloakopenid]
end
