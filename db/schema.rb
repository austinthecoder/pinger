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

ActiveRecord::Schema.define(:version => 20131004050705) do

  create_table "alerts", :force => true do |t|
    t.integer  "location_id"
    t.integer  "email_callback_id"
    t.string   "code_is_not"
    t.integer  "times"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alerts", ["email_callback_id"], :name => "index_alerts_on_email_callback_id"
  add_index "alerts", ["location_id"], :name => "index_alerts_on_location_id"

  create_table "email_callbacks", :force => true do |t|
    t.string   "to"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "url"
    t.string   "http_method"
    t.integer  "seconds"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",       :null => false
  end

  create_table "pings", :force => true do |t|
    t.integer  "location_id"
    t.datetime "performed_at"
    t.string   "response_status_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
