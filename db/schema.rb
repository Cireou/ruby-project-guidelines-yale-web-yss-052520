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

ActiveRecord::Schema.define(version: 2020_06_10_142342) do

  create_table "actions", force: :cascade do |t|
    t.text "rep_action"
    t.integer "bill_id"
    t.integer "representative_id"
    t.string "vote"
  end

  create_table "bills", force: :cascade do |t|
    t.string "title"
    t.date "date_proposed"
    t.boolean "passed"
    t.date "date_pass_reject"
    t.text "summary"
    t.string "link"
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

end
