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

ActiveRecord::Schema[7.1].define(version: 2023_12_19_003009) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "occurrences", comment: "Ocorrências", force: :cascade do |t|
    t.bigint "project_id", null: false, comment: "Projeto ao qual a ocorrência está relacionada"
    t.string "public_id", null: false, comment: "ID público da ocorrência"
    t.string "source", default: "unknown", null: false, comment: "Fonte ou origem da ocorrência (ex: ruby, javascript, unknown)"
    t.string "severity", comment: "Nível de gravidade da ocorrência (ex: warning, error, critical)"
    t.string "state", default: "open", null: false, comment: "Estado atual da ocorrência (ex: open, closed)"
    t.boolean "read", default: false, null: false, comment: "Indica se a ocorrência foi lida ou não"
    t.string "type", comment: "Tipo ou categoria da ocorrência (ex: NoMethodError, SyntaxError)"
    t.string "message", comment: "Mensagem da ocorrência"
    t.text "stack", comment: "Stack trace associado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "public_id"], name: "index_occurrences_on_project_id_and_public_id", unique: true
  end

  create_table "project_memberships", comment: "Associações de usuários a projetos", force: :cascade do |t|
    t.bigint "project_id", null: false, comment: "Projeto ao qual o usuário está associado"
    t.bigint "user_id", null: false, comment: "Usuário associado ao projeto"
    t.datetime "joined_at", default: -> { "now()" }, null: false, comment: "Data em que o usuário se associou ao projeto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "user_id"], name: "index_project_memberships_on_project_id_and_user_id", unique: true
  end

  create_table "projects", comment: "Projetos", force: :cascade do |t|
    t.bigint "owner_id", null: false, comment: "Usuário proprietário do projeto"
    t.string "public_id", null: false, comment: "ID público do projeto"
    t.string "secret", null: false, comment: "Chave secreta utilizada para vincular ocorrências ao projeto"
    t.string "name", null: false, comment: "Nome do projeto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_projects_on_owner_id"
    t.index ["public_id"], name: "index_projects_on_public_id", unique: true
  end

  create_table "users", comment: "Usuários", force: :cascade do |t|
    t.string "first_name", null: false, comment: "Primeiro nome do usuário"
    t.string "last_name", null: false, comment: "Sobrenome do usuário"
    t.string "email", null: false, comment: "Endereço de e-mail, único para cada usuário"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider", null: false, comment: "Provedor de autenticação OAuth"
    t.uuid "uid", null: false, comment: "ID do usuário fornecido pelo provedor OAuth"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
  end

  add_foreign_key "occurrences", "projects", on_delete: :cascade
  add_foreign_key "project_memberships", "projects", on_delete: :cascade
  add_foreign_key "project_memberships", "users", on_delete: :cascade
  add_foreign_key "projects", "users", column: "owner_id", on_delete: :cascade
end
