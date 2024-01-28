# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects, id: :ulid, default: -> { 'gen_ulid()' }, comment: 'Projetos' do |t|
      t.references :owner, type: :ulid, null: false, foreign_key: { to_table: :users, on_delete: :cascade },
        comment: 'Usuário proprietário do projeto'
      t.string :name, null: false, comment: 'Nome do projeto'
      t.string :token, null: false, comment: 'Token utilizado para vincular eventos ao projeto'

      t.timestamps default: -> { 'now()' }
    end
  end
end
