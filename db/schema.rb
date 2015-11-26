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

ActiveRecord::Schema.define(version: 20140828183113) do

  create_table "comments", force: :cascade do |t|
    t.integer  "author_id",        limit: 4
    t.text     "text",             limit: 65535
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id", using: :btree
  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree

  create_table "notification_settings", force: :cascade do |t|
    t.boolean  "new_comment_followed_story", limit: 1, default: true
    t.boolean  "new_rating",                 limit: 1, default: true
    t.boolean  "new_comment",                limit: 1, default: true
    t.integer  "user_id",                    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notification_settings", ["user_id"], name: "index_notification_settings_on_user_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.boolean  "positive",      limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["rateable_type", "rateable_id"], name: "index_ratings_on_rateable_type_and_rateable_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "stories", force: :cascade do |t|
    t.text     "description",    limit: 65535
    t.string   "url",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",        limit: 4
    t.integer  "rating_counter", limit: 4,     default: 0
  end

  add_index "stories", ["user_id"], name: "index_stories_on_user_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",               limit: 255, default: "", null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "facebook_image",         limit: 255
    t.string   "name",                   limit: 255
    t.string   "auth_token",             limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
