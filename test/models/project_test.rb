# frozen_string_literal: true

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test 'validates presence of name' do
    project = Project.new

    assert_not project.save
    assert_includes project.errors.messages[:name], 'não pode ficar em branco'
  end

  test 'validates presence of token' do
    project = Project.new

    assert_not project.save
    assert_includes project.errors.messages[:token], 'não pode ficar em branco'
  end
end
