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

ActiveRecord::Schema.define(version: 2019_04_01_212906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "code"
    t.string "type"
    t.string "base_token_10"
    t.string "base_token_20"
    t.string "base_token_30"
    t.string "base_token_40"
    t.string "base_token_50"
    t.string "base_token_60"
    t.string "base_token_70"
    t.string "base_token_80"
    t.string "base_token_90"
    t.string "base_token_100"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
