# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: :ulid, default: -> { 'gen_ulid()' }, comment: 'Usuários' do |t|
      t.string :first_name, null: false, comment: 'Primeiro nome do usuário'
      t.string :last_name, null: false, comment: 'Sobrenome do usuário'
      t.string :email, null: false, comment: 'Endereço de e-mail, único para cada usuário'
      # t.string :provider, null: false, comment: 'Provedor de autenticação OAuth'
      # t.uuid :uid, null: false, comment: 'ID do usuário fornecido pelo provedor OAuth'

      t.timestamps default: -> { 'now()' }
    end

    add_index :users, :email, unique: true
  end
end
