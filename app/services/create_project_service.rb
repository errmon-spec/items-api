# frozen_string_literal: true

class CreateProjectService
  PROJECT_PUBLIC_TOKEN_LENGTH = 20

  def self.call(user:, name:)
    new(user:, name:).call
  end

  def initialize(user:, name:)
    @user = user
    @name = name
  end

  def call
    user.projects.create!(name:, token: generate_token)
  end

  private

  attr_reader :user, :name

  def generate_token
    SecureRandom.hex(PROJECT_PUBLIC_TOKEN_LENGTH)
  end
end
