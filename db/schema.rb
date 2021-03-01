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

ActiveRecord::Schema.define(version: 2021_03_01_182107) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "match_id", null: false
    t.integer "bet_team_score", default: 0, null: false
    t.integer "bet_opponent_score", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_bets_on_match_id"
    t.index ["user_id", "match_id"], name: "index_bets_on_user_id_and_match_id", unique: true
    t.index ["user_id"], name: "index_bets_on_user_id"
  end

  create_table "championships", force: :cascade do |t|
    t.bigint "league_id", null: false
    t.integer "number_of_participants"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "year", null: false
    t.bigint "[:league_id, :year]_id"
    t.index ["[:league_id, :year]_id"], name: "index_championships_on_[:league_id, :year]_id"
    t.index ["league_id"], name: "index_championships_on_league_id"
  end

  create_table "divisions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "global_settings", force: :cascade do |t|
    t.bigint "championship_id", null: false
    t.integer "singleton_guard", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cbf_url"
    t.index ["championship_id"], name: "index_global_settings_on_championship_id"
    t.index ["singleton_guard"], name: "index_global_settings_on_singleton_guard", unique: true
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "division_id"
    t.index ["division_id", "name"], name: "index_leagues_on_division_id_and_name", unique: true
    t.index ["division_id"], name: "index_leagues_on_division_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "championship_id", null: false
    t.bigint "team_id", null: false
    t.bigint "opponent_id", null: false
    t.integer "id_match", null: false
    t.string "number_of_changes"
    t.string "place"
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "round_id", null: false
    t.integer "team_score"
    t.integer "opponent_score"
    t.index ["championship_id", "id_match"], name: "index_matches_on_championship_id_and_id_match", unique: true
    t.index ["championship_id"], name: "index_matches_on_championship_id"
    t.index ["date"], name: "index_matches_on_date"
    t.index ["opponent_id"], name: "index_matches_on_opponent_id"
    t.index ["round_id"], name: "index_matches_on_round_id"
    t.index ["team_id"], name: "index_matches_on_team_id"
  end

  create_table "rankings", force: :cascade do |t|
    t.bigint "championship_id", null: false
    t.bigint "team_id", null: false
    t.bigint "next_opponent_id", null: false
    t.integer "posicao", null: false
    t.integer "pontos"
    t.integer "jogos"
    t.integer "vitorias"
    t.integer "empates"
    t.integer "derrotas"
    t.integer "gols_pro"
    t.integer "gols_contra"
    t.integer "saldo_de_gols"
    t.integer "cartoes_amarelos"
    t.integer "cartoes_vermelhos"
    t.integer "aproveitamento"
    t.string "recentes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "[:championship_id, :position]_id"
    t.bigint "[:championship_id, :id_match]_id"
    t.index ["[:championship_id, :id_match]_id"], name: "index_rankings_on_[:championship_id, :id_match]_id"
    t.index ["[:championship_id, :position]_id"], name: "index_rankings_on_[:championship_id, :position]_id"
    t.index ["championship_id"], name: "index_rankings_on_championship_id"
    t.index ["next_opponent_id"], name: "index_rankings_on_next_opponent_id"
    t.index ["team_id"], name: "index_rankings_on_team_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.bigint "championship_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "number", null: false
    t.bigint "[:championship_id, :number]_id"
    t.index ["[:championship_id, :number]_id"], name: "index_rounds_on_[:championship_id, :number]_id"
    t.index ["championship_id"], name: "index_rounds_on_championship_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "avatar_url"
    t.index ["name"], name: "index_teams_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uid"
    t.string "jti"
    t.string "provider"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bets", "matches"
  add_foreign_key "bets", "users"
  add_foreign_key "championships", "leagues"
  add_foreign_key "global_settings", "championships"
  add_foreign_key "matches", "championships"
  add_foreign_key "matches", "rounds"
  add_foreign_key "matches", "teams"
  add_foreign_key "matches", "teams", column: "opponent_id"
  add_foreign_key "rankings", "championships"
  add_foreign_key "rankings", "teams"
  add_foreign_key "rankings", "teams", column: "next_opponent_id"
  add_foreign_key "rounds", "championships"
end
