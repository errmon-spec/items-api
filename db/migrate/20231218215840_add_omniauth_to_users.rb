# frozen_string_literal: true

class AddOmniauthToUsers < ActiveRecord::Migration[7.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :provider, null: false, comment: 'Provedor de autenticação OAuth'
      t.uuid :uid, null: false, comment: 'ID do usuário fornecido pelo provedor OAuth'
    end

    add_index :users, %i[provider uid], unique: true
  end
end
