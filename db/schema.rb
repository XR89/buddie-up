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

ActiveRecord::Schema.define(version: 2021_09_08_212244) do

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
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "avoid_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "avoid_user_id"
    t.index ["avoid_user_id"], name: "index_avoid_users_on_avoid_user_id"
    t.index ["user_id"], name: "index_avoid_users_on_user_id"
  end

  create_table "chats", force: :cascade do |t|
    t.boolean "ongoing"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "game_id"
    t.index ["game_id"], name: "index_chats_on_game_id"
  end

  create_table "favourite_games", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_favourite_games_on_game_id"
    t.index ["user_id"], name: "index_favourite_games_on_user_id"
  end

  create_table "favourite_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "favourite_user_id"
    t.index ["favourite_user_id"], name: "index_favourite_users_on_favourite_user_id"
    t.index ["user_id"], name: "index_favourite_users_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "title"
    t.string "genre", default: [], array: true
    t.text "description"
    t.string "developer"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "background_image_url"
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_ready"
    t.bigint "inviter_id", null: false
    t.bigint "chat_id", null: false
    t.index ["chat_id"], name: "index_invitations_on_chat_id"
    t.index ["inviter_id"], name: "index_invitations_on_inviter_id"
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "chat_id", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "user_ratings", force: :cascade do |t|
    t.float "rating"
    t.bigint "user_id", null: false
    t.text "comments"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "reviewee_id"
    t.index ["reviewee_id"], name: "index_user_ratings_on_reviewee_id"
    t.index ["user_id"], name: "index_user_ratings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.string "region"
    t.date "dob"
    t.string "gender"
    t.string "language", default: [], array: true
    t.string "steam_handle"
    t.string "origin_handle"
    t.string "psn_handle"
    t.string "epic_handle"
    t.string "discord_handle"
    t.string "live_handle"
    t.string "gog_handle"
    t.string "twich_handle"
    t.string "battlenet_handle"
    t.string "favourite_games", default: [], array: true
    t.integer "favourite_users", default: [], array: true
    t.integer "avoid_users", default: [], array: true
    t.integer "user_status"
    t.bigint "session_id"
    t.float "average_rating", default: 0.0
    t.string "tagline"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["session_id"], name: "index_users_on_session_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "avoid_users", "users"
  add_foreign_key "avoid_users", "users", column: "avoid_user_id"
  add_foreign_key "chats", "games"
  add_foreign_key "favourite_games", "games"
  add_foreign_key "favourite_games", "users"
  add_foreign_key "favourite_users", "users"
  add_foreign_key "favourite_users", "users", column: "favourite_user_id"
  add_foreign_key "invitations", "chats"
  add_foreign_key "invitations", "users"
  add_foreign_key "invitations", "users", column: "inviter_id"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users"
  add_foreign_key "user_ratings", "users"
  add_foreign_key "user_ratings", "users", column: "reviewee_id"
  add_foreign_key "users", "chats", column: "session_id"
end
