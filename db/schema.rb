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

ActiveRecord::Schema.define(version: 20131022162258) do

  create_table "15min", id: false, force: true do |t|
    t.integer  "id",         default: 0, null: false
    t.integer  "user_id"
    t.integer  "future_id"
    t.integer  "time_id"
    t.integer  "method"
    t.integer  "status"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "30min", id: false, force: true do |t|
    t.integer  "id",         default: 0, null: false
    t.integer  "user_id"
    t.integer  "future_id"
    t.integer  "time_id"
    t.integer  "method"
    t.integer  "status"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "45min", id: false, force: true do |t|
    t.integer  "id",         default: 0, null: false
    t.integer  "user_id"
    t.integer  "future_id"
    t.integer  "time_id"
    t.integer  "method"
    t.integer  "status"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "60min", id: false, force: true do |t|
    t.integer  "id",         default: 0, null: false
    t.integer  "user_id"
    t.integer  "future_id"
    t.integer  "time_id"
    t.integer  "method"
    t.integer  "status"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "futures", force: true do |t|
    t.string   "name"
    t.string   "alias"
    t.float    "valuenew"
    t.float    "valueold"
    t.integer  "updated"
    t.string   "timestamp",  limit: 50
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "invitations", force: true do |t|
    t.integer  "sender_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "send_at"
    t.string   "new"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", force: true do |t|
    t.integer  "user_id"
    t.integer  "method_id"
    t.string   "text"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscribers", force: true do |t|
    t.integer  "user_id"
    t.integer  "future_id"
    t.integer  "time_id"
    t.integer  "method"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "mail"
    t.string   "phone"
    t.integer  "count_sms"
    t.string   "encrypted_password"
    t.string   "salt"
    t.integer  "admin"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "invitation_id"
    t.string   "invitation_limit"
    t.string   "integer"
  end

end
