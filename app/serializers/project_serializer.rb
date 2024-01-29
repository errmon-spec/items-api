# frozen_string_literal: true

class ProjectSerializer < ApplicationSerializer
  def initialize(project)
    @project = project
  end

  def as_json
    {
      id: project.id,
      owner_id: project.owner_id,
      name: project.name,
      token: project.token,
      created_at: project.created_at,
      updated_at: project.updated_at,
    }
  end

  private

  attr_reader :project
end
