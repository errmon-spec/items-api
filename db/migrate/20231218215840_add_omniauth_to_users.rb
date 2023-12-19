# frozen_string_literal: true

class AddOmniauthToUsers < ActiveRecord::Migration[7.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :provider, null: false
      t.string :uid, null: false
    end

    add_index :users, %i[provider uid], unique: true
  end
end
