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

ActiveRecord::Schema.define(version: 2020_06_11_071503) do

  create_table "amendments", force: :cascade do |t|
    t.string "decision"
    t.string "decision_date"
    t.integer "roll_call_num"
    t.string "description"
    t.integer "session_num"
    t.integer "bill_id"
  end

  create_table "bills", force: :cascade do |t|
    t.string "title"
    t.date "date_proposed"
    t.text "summary"
    t.string "link"
    t.string "bill_id"
    t.string "sponsor"
  end

  create_table "cosponsors", force: :cascade do |t|
    t.integer "bill_id"
    t.string "rep_id"
  end

  create_table "representatives", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.integer "experience"
    t.string "district"
    t.string "party"
    t.string "next_election"
    t.string "state"
    t.string "rep_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "username"
    t.text "password"
    t.text "address"
  end

  create_table "votes", force: :cascade do |t|
    t.integer "bill_id"
    t.string "representative_id"
    t.string "vote"
  end

end
