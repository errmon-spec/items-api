# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_enum :item_state, %w[active resolved muted]
    create_enum :item_level, %w[debug info warning error critical]

    create_table :items, id: :ulid, default: -> { 'gen_ulid()' }, comment: 'Itens' do |t|
      t.references :project, type: :ulid, null: false, foreign_key: { on_delete: :cascade },
        comment: 'Projeto relacionado'
      t.string :library, comment: 'Biblioteca ou integração que reportou o item'
      t.string :revision, comment: 'Versão ou git commit SHA'
      t.enum :status, enum_type: :item_state, null: false, default: :active,
        comment: 'Status do item'
      t.boolean :read, null: false, default: false, comment: 'Indica se o item foi lido ou não'
      t.enum :level, enum_type: :item_level, null: false, default: :error,
        comment: 'Nível de gravidade do item'
      t.string :type, comment: 'Tipo ou categoria do item (NoMethodError, SyntaxError, etc.)'
      t.string :message, comment: 'Mensagem associada ao item'
      t.text :stack_trace, comment: 'Stack trace associado ao item'

      t.timestamps default: -> { 'now()' }
    end

    add_index :items, %i[project_id revision]
  end
end
