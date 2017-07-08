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

ActiveRecord::Schema.define(version: 20170520155103) do

  create_table "abilities", force: :cascade do |t|
    t.integer  "freelancer_id"
    t.integer  "ab_index"
    t.string   "damage"
    t.string   "heal"
    t.string   "shield"
    t.string   "energy"
    t.string   "cooldown"
    t.string   "range"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "date"
    t.string   "time"
    t.integer  "num_matches"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "event_type"
    t.integer  "league_id"
    t.string   "status",      default: "open"
  end

  create_table "events_teams", id: false, force: :cascade do |t|
    t.integer "team_id"
    t.integer "event_id"
  end

  create_table "freelancers", force: :cascade do |t|
    t.string   "name"
    t.string   "sub_name"
    t.string   "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "freelancers_matches", id: false, force: :cascade do |t|
    t.integer "freelancer_id"
    t.integer "event_id"
  end

  create_table "grules", force: :cascade do |t|
    t.integer "fl_bans",       default: 1
    t.integer "map_bans",      default: 1
    t.integer "min_team_size", default: 4
    t.integer "max_team_size", default: 6
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "round"
    t.integer  "home_team"
    t.string   "map_ban"
    t.string   "map_pick"
    t.string   "home_pb_file_name"
    t.string   "home_pb_content_type"
    t.integer  "home_pb_file_size"
    t.datetime "home_pb_updated_at"
    t.string   "away_pb_file_name"
    t.string   "away_pb_content_type"
    t.integer  "away_pb_file_size"
    t.datetime "away_pb_updated_at"
    t.string   "home_end_file_name"
    t.string   "home_end_content_type"
    t.integer  "home_end_file_size"
    t.datetime "home_end_updated_at"
    t.string   "away_end_file_name"
    t.string   "away_end_content_type"
    t.integer  "away_end_file_size"
    t.datetime "away_end_updated_at"
    t.integer  "win_team"
    t.integer  "away_team"
    t.integer  "event_id"
  end

  create_table "matches_teams", id: false, force: :cascade do |t|
    t.integer "team_id"
    t.integer "match_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "msg_type"
  end

  create_table "mods", force: :cascade do |t|
    t.integer  "ability_id"
    t.string   "name"
    t.string   "description"
    t.string   "cost"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.string   "username"
    t.string   "glyphtag"
    t.string   "favorite_role"
    t.string   "favorite_freelancer"
    t.text     "bio"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "freeagent",           default: false
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.boolean  "firepower",           default: false
    t.boolean  "frontline",           default: false
    t.boolean  "support",             default: false
    t.boolean  "any",                 default: true
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "user_type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
