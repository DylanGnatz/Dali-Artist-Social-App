# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_11_17_034925) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "artworks", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.boolean "onPortfolio"
    t.string "type", limit: 100
    t.string "title", limit: 100
    t.string "link", limit: 100
    t.string "description", limit: 2000
    t.boolean "isPrivate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_artworks_on_profile_id"
  end

  create_table "chats", force: :cascade do |t|
    t.datetime "last_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chats_messages", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.bigint "chat_id", null: false
    t.string "msg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_chats_messages_on_chat_id"
    t.index ["profile_id"], name: "index_chats_messages_on_profile_id"
  end

  create_table "chats_profiles", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.bigint "chat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_chats_profiles_on_chat_id"
    t.index ["profile_id"], name: "index_chats_profiles_on_profile_id"
  end

  create_table "collectives", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "chat_id", null: false
    t.index ["chat_id"], name: "index_collectives_on_chat_id"
  end

  create_table "collectives_profiles", force: :cascade do |t|
    t.bigint "collective_id", null: false
    t.bigint "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collective_id"], name: "index_collectives_profiles_on_collective_id"
    t.index ["profile_id"], name: "index_collectives_profiles_on_profile_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.string "title"
    t.datetime "date"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_events_on_profile_id"
  end

  create_table "friends", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.integer "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_friends_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", limit: 100, null: false
    t.string "bio", limit: 2000
    t.date "date_of_birth"
    t.bigint "user_id"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "profiles_tags", force: :cascade do |t|
    t.bigint "profile_id"
    t.bigint "tag_id"
    t.index ["profile_id"], name: "index_profiles_tags_on_profile_id"
    t.index ["tag_id"], name: "index_profiles_tags_on_tag_id"
  end

  create_table "search_settings", force: :cascade do |t|
    t.bigint "profile_id"
    t.integer "search_radius"
    t.boolean "gender_restrict"
    t.boolean "tag_restrict"
    t.boolean "show_events"
    t.boolean "show_profiles"
    t.boolean "show_collectives"
    t.index ["profile_id"], name: "index_search_settings_on_profile_id"
  end

  create_table "swipes", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.integer "swiped_id", null: false
    t.boolean "interested", null: false
    t.datetime "swipe_time", null: false
    t.index ["profile_id"], name: "index_swipes_on_profile_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "artworks", "profiles"
  add_foreign_key "chats_messages", "chats"
  add_foreign_key "chats_messages", "profiles"
  add_foreign_key "chats_profiles", "chats"
  add_foreign_key "chats_profiles", "profiles"
  add_foreign_key "collectives", "chats"
  add_foreign_key "collectives_profiles", "collectives"
  add_foreign_key "collectives_profiles", "profiles"
  add_foreign_key "events", "profiles"
  add_foreign_key "friends", "profiles"
  add_foreign_key "swipes", "profiles"
end
