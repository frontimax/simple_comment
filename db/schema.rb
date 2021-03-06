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

ActiveRecord::Schema.define(version: 20170129094646) do

  create_table "countries", force: :cascade do |t|
    t.string   "country"
    t.string   "country_code"
    t.string   "currency"
    t.string   "currency_code"
    t.boolean  "active"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "country_codes", force: :cascade do |t|
    t.string   "country"
    t.string   "country_code"
    t.string   "currency"
    t.string   "currency_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "segments", force: :cascade do |t|
    t.string   "type"
    t.string   "title",                      null: false
    t.text     "content",                    null: false
    t.boolean  "active",      default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "parent_type"
    t.integer  "parent_id"
    t.integer  "user_id"
  end

  create_table "table_countries", force: :cascade do |t|
    t.string   "country",                      null: false
    t.string   "country_code"
    t.string   "currency"
    t.string   "currency_code"
    t.boolean  "active",        default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                                       null: false
    t.string   "email",                                      null: false
    t.string   "country",                default: "Germany"
    t.string   "country_code",           default: "de"
    t.string   "currency",               default: "Mark"
    t.string   "currency_code",          default: "DEM"
    t.boolean  "active",                 default: true
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin_role",             default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
