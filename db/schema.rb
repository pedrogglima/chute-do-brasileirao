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

ActiveRecord::Schema.define(version: 2021_02_06_181238) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "match_id", null: false
    t.integer "score_team", default: 0, null: false
    t.integer "score_opponent", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_bets_on_match_id"
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

  create_table "leagues", force: :cascade do |t|
    t.string "name", null: false
    t.string "division"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "division"], name: "index_leagues_on_name_and_division", unique: true
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "championship_id", null: false
    t.bigint "team_id", null: false
    t.bigint "opponent_id", null: false
    t.string "identification", null: false
    t.string "number_of_changes"
    t.string "place"
    t.datetime "date"
    t.string "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "round_id", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bets", "matches"
  add_foreign_key "bets", "users"
  add_foreign_key "championships", "leagues"
  add_foreign_key "matches", "championships"
  add_foreign_key "matches", "rounds"
  add_foreign_key "matches", "teams"
  add_foreign_key "matches", "teams", column: "opponent_id"
  add_foreign_key "rankings", "championships"
  add_foreign_key "rankings", "teams"
  add_foreign_key "rankings", "teams", column: "next_opponent_id"
  add_foreign_key "rounds", "championships"
end
