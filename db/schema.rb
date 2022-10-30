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

ActiveRecord::Schema[7.0].define(version: 2022_10_30_155234) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "swipes", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.integer "swiped_id", null: false
    t.boolean "interested", null: false
    t.datetime "swipe_time", null: false
    t.index ["profile_id"], name: "index_swipes_on_profile_id"
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

  add_foreign_key "chats_messages", "chats"
  add_foreign_key "chats_messages", "profiles"
  add_foreign_key "chats_profiles", "chats"
  add_foreign_key "chats_profiles", "profiles"
  add_foreign_key "friends", "profiles"
  add_foreign_key "swipes", "profiles"
end
