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

ActiveRecord::Schema.define(version: 20161025175639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "response_to_comment_id"
    t.string   "commenter_name",                         null: false
    t.text     "comment",                                null: false
    t.boolean  "is_approved",                            null: false
    t.datetime "approved_at"
    t.boolean  "is_deleted",             default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entry_id"
  end

  create_table "entries", force: :cascade do |t|
    t.string   "title",                          null: false
    t.text     "entry",                          null: false
    t.text     "summary",                        null: false
    t.boolean  "is_published",   default: false, null: false
    t.datetime "published_at"
    t.boolean  "is_deleted",     default: false, null: false
    t.datetime "deleted_at"
    t.text     "tags",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id",                    null: false
    t.boolean  "allow_comments", default: true,  null: false
  end

  add_index "entries", ["category_id"], name: "index_entries_on_category_id", using: :btree

  create_table "historical_entries", force: :cascade do |t|
    t.string   "title",           null: false
    t.text     "entry",           null: false
    t.text     "summary",         null: false
    t.text     "tags",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id",     null: false
    t.integer  "parent_entry_id", null: false
  end

  add_index "historical_entries", ["category_id"], name: "index_historical_entries_on_category_id", using: :btree
  add_index "historical_entries", ["parent_entry_id"], name: "index_historical_entries_on_parent_entry_id", using: :btree

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

  create_table "settings", force: :cascade do |t|
    t.string   "blog_title",                               null: false
    t.string   "blog_subtitle",                            null: false
    t.boolean  "display_bio",                              null: false
    t.text     "bio",                                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "banner_image_id"
    t.string   "title_color"
    t.text     "copyright"
    t.boolean  "require_comment_approval", default: false, null: false
  end

  create_table "trackers", force: :cascade do |t|
    t.integer  "status_code",     null: false
    t.string   "user_agent",      null: false
    t.string   "source_ip",       null: false
    t.string   "url",             null: false
    t.string   "referer"
    t.string   "accept_language"
    t.string   "x_forwarded_for"
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

  add_foreign_key "comments", "comments", column: "response_to_comment_id", name: "response_to_comment_fk"
  add_foreign_key "comments", "entries"
  add_foreign_key "entries", "categories", name: "entry_category_fk"
  add_foreign_key "historical_entries", "categories", name: "historical_entry_category_fk"
  add_foreign_key "historical_entries", "entries", column: "parent_entry_id", name: "historical_entry_entry_fk"
  add_foreign_key "settings", "images", column: "banner_image_id", name: "settings_banner_image_fk"
end
