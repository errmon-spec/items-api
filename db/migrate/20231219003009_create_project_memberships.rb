# frozen_string_literal: true

class CreateProjectMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :project_memberships, comment: 'Associação entre usuários e projetos' do |t|
      t.references :project, type: :ulid, null: false, foreign_key: { on_delete: :cascade }, index: false
      t.references :user, type: :ulid, null: false, foreign_key: { on_delete: :cascade }, index: false
      t.datetime :created_at, null: false, default: -> { 'now()' }
    end

    add_index :project_memberships, %i[project_id user_id], unique: true
  end
end
