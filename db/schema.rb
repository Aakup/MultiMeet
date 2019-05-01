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

ActiveRecord::Schema.define(version: 20190428045610) do

  create_table "matchings", force: :cascade do |t|
    t.integer "project_id",  null: false
    t.string  "output_json", null: false
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "project_id",     null: false
    t.string   "email",          null: false
    t.datetime "last_responded"
    t.string   "secret_id"
  end

  add_index "participants", ["project_id", "email", "last_responded"], name: "index_participants_on_project_id_and_email_and_last_responded", unique: true

  create_table "project_times", force: :cascade do |t|
    t.integer  "project_id",                 null: false
    t.datetime "date_time",                  null: false
    t.boolean  "is_date",    default: false, null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string  "project_name", null: false
    t.integer "user_id",      null: false
    t.integer "duration"
  end

  create_table "rankings", force: :cascade do |t|
    t.integer "rank"
    t.integer "participant_id",  null: false
    t.integer "project_time_id", null: false
  end

  add_index "rankings", ["participant_id", "project_time_id"], name: "index_rankings_on_participant_id_and_project_time_id", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password"
    t.string   "password_confirmation"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
