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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111102194224) do

  create_table "flights", :force => true do |t|
    t.string   "flight_number"
    t.string   "name"
    t.string   "departure_location"
    t.string   "arrival_location"
    t.datetime "planned_departure"
    t.datetime "planned_arrival"
    t.datetime "actual_departure"
    t.datetime "actual_arrival"
    t.datetime "updated_at"
    t.string   "departure_terminal"
    t.string   "arrival_terminal"
    t.datetime "created_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "flight_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "mail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
