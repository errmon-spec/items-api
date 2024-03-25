# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_03_25_013703) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "ulid"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "item_level", ["debug", "info", "warning", "error", "critical"]
  create_enum "item_state", ["active", "resolved", "muted"]

  create_table "items", id: :ulid, default: -> { "gen_ulid()" }, comment: "Itens", force: :cascade do |t|
    t.ulid "project_id", null: false, comment: "Projeto relacionado"
    t.string "library", comment: "Biblioteca ou integração que reportou o item"
    t.string "revision", comment: "Versão ou git commit SHA"
    t.enum "status", default: "active", null: false, comment: "Status do item", enum_type: "item_state"
    t.boolean "read", default: false, null: false, comment: "Indica se o item foi lido ou não"
    t.enum "level", default: "error", null: false, comment: "Nível de gravidade do item", enum_type: "item_level"
    t.string "type", comment: "Tipo ou categoria do item (NoMethodError, SyntaxError, etc.)"
    t.string "message", comment: "Mensagem associada ao item"
    t.text "stack_trace", comment: "Stack trace associado ao item"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["project_id", "revision"], name: "index_items_on_project_id_and_revision"
    t.index ["project_id"], name: "index_items_on_project_id"
  end

  create_table "project_memberships", comment: "Associação entre usuários e projetos", force: :cascade do |t|
    t.ulid "project_id", null: false
    t.ulid "user_id", null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.index ["project_id", "user_id"], name: "index_project_memberships_on_project_id_and_user_id", unique: true
  end

  create_table "projects", id: :ulid, default: -> { "gen_ulid()" }, comment: "Projetos", force: :cascade do |t|
    t.ulid "owner_id", null: false, comment: "Usuário proprietário do projeto"
    t.string "name", null: false, comment: "Nome do projeto"
    t.string "token", null: false, comment: "Token utilizado para vincular eventos ao projeto"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["owner_id"], name: "index_projects_on_owner_id"
  end

  create_table "users", id: :ulid, default: -> { "gen_ulid()" }, comment: "Usuários", force: :cascade do |t|
    t.string "given_name", null: false, comment: "Primeiro nome do usuário"
    t.string "family_name", null: false, comment: "Sobrenome do usuário"
    t.string "email", null: false, comment: "Endereço de e-mail, único para cada usuário"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.string "provider", null: false, comment: "Provedor de autenticação OAuth"
    t.uuid "uid", null: false, comment: "ID do usuário fornecido pelo provedor OAuth"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
  end

  add_foreign_key "items", "projects", on_delete: :cascade
  add_foreign_key "project_memberships", "projects", on_delete: :cascade
  add_foreign_key "project_memberships", "users", on_delete: :cascade
  add_foreign_key "projects", "users", column: "owner_id", on_delete: :cascade
end
