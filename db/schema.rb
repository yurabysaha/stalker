# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160418075810) do

  create_table "factories", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "budget"
    t.integer  "salary"
    t.integer  "location_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "factories", ["location_id"], name: "index_factories_on_location_id"

  create_table "fights", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "opponent_id"
    t.integer  "who_move"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "price"
    t.string   "body_type"
    t.integer  "min_lvl"
    t.integer  "strength"
    t.integer  "amount"
    t.integer  "factory_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "items", ["factory_id"], name: "index_items_on_factory_id"

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_bodies", force: :cascade do |t|
    t.integer  "head"
    t.integer  "body"
    t.integer  "hand"
    t.integer  "leg"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_bodies", ["user_id"], name: "index_user_bodies_on_user_id"

  create_table "user_items", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "body_type"
    t.integer  "min_lvl"
    t.integer  "strength"
    t.string   "avatar"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "user_items", ["user_id"], name: "index_user_items_on_user_id"

  create_table "user_profiles", force: :cascade do |t|
    t.integer  "health",      default: 100
    t.integer  "endurance",   default: 50
    t.integer  "weight",      default: 0
    t.integer  "rank",        default: 0
    t.integer  "reputation",  default: 0
    t.integer  "money",       default: 1000
    t.integer  "user_id"
    t.integer  "location_id", default: 1
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "work_on"
    t.datetime "work_end"
  end

  add_index "user_profiles", ["location_id"], name: "index_user_profiles_on_location_id"
  add_index "user_profiles", ["user_id"], name: "index_user_profiles_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "mail"
    t.string   "password_digest"
    t.string   "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
