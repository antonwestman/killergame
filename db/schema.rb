# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170324170445) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_kills", force: :cascade do |t|
    t.integer  "killer_id",                          null: false
    t.integer  "victim_id",                          null: false
    t.integer  "round_id",                           null: false
    t.string   "status",     default: "unconfirmed", null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["killer_id"], name: "index_game_kills_on_killer_id", using: :btree
    t.index ["round_id"], name: "index_game_kills_on_round_id", using: :btree
    t.index ["victim_id"], name: "index_game_kills_on_victim_id", using: :btree
  end

  create_table "game_missions", force: :cascade do |t|
    t.integer  "player_id",  null: false
    t.integer  "target_id",  null: false
    t.integer  "place_id",   null: false
    t.integer  "weapon_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_game_missions_on_place_id", using: :btree
    t.index ["player_id"], name: "index_game_missions_on_player_id", using: :btree
    t.index ["target_id"], name: "index_game_missions_on_target_id", using: :btree
    t.index ["weapon_id"], name: "index_game_missions_on_weapon_id", using: :btree
  end

  create_table "game_players", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "round_id"
    t.string   "player_name"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "status",      default: "alive", null: false
    t.index ["round_id"], name: "index_game_players_on_round_id", using: :btree
    t.index ["user_id"], name: "index_game_players_on_user_id", using: :btree
  end

  create_table "game_rounds", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "ongoing",    default: true
    t.string   "name"
  end

  create_table "places", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_places_on_name", unique: true, using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.datetime "deleted_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  create_table "weapons", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_weapons_on_name", unique: true, using: :btree
  end

  add_foreign_key "game_kills", "game_players", column: "killer_id"
  add_foreign_key "game_kills", "game_players", column: "victim_id"
  add_foreign_key "game_kills", "game_rounds", column: "round_id"
  add_foreign_key "game_missions", "game_players", column: "player_id"
  add_foreign_key "game_missions", "game_players", column: "target_id"
  add_foreign_key "game_missions", "places"
  add_foreign_key "game_missions", "weapons"
  add_foreign_key "game_players", "game_rounds", column: "round_id"
  add_foreign_key "game_players", "users"
end
