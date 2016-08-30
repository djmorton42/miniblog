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

ActiveRecord::Schema.define(version: 20160821153000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entries", force: :cascade do |t|
    t.string   "title",                        null: false
    t.text     "entry",                        null: false
    t.text     "summary",                      null: false
    t.boolean  "is_published", default: false, null: false
    t.datetime "published_at"
    t.boolean  "is_deleted",   default: false, null: false
    t.datetime "deleted_at"
    t.text     "tags",                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id",                  null: false
  end

  add_index "entries", ["category_id"], name: "index_entries_on_category_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "title",                        null: false
    t.string   "url_token",                    null: false
    t.string   "file_name",                    null: false
    t.string   "content_type",                 null: false
    t.boolean  "is_published", default: false, null: false
    t.datetime "published_at"
    t.boolean  "is_deleted",   default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",         null: false
    t.string   "password_hash", null: false
    t.string   "name",          null: false
    t.datetime "last_login"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "entries", "categories", name: "entry_category_fk"
end
