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

ActiveRecord::Schema.define(version: 2018_06_23_025022) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "dispositions", force: :cascade do |t|
    t.bigint "painting_id"
    t.bigint "room_id"
    t.boolean "reproduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_dispositions_on_deleted_at"
    t.index ["painting_id"], name: "index_dispositions_on_painting_id"
    t.index ["room_id"], name: "index_dispositions_on_room_id"
  end

  create_table "painting_kinds", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_painting_kinds_on_deleted_at"
  end

  create_table "paintings", force: :cascade do |t|
    t.string "title"
    t.bigint "painting_kind_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.integer "lock_version", default: 0
    t.index ["deleted_at"], name: "index_paintings_on_deleted_at"
    t.index ["painting_kind_id"], name: "index_paintings_on_painting_kind_id"
    t.index ["user_id"], name: "index_paintings_on_user_id"
  end

  create_table "ranks", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_ranks_on_deleted_at"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "title"
    t.string "position"
    t.float "area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_rooms_on_deleted_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password"
    t.string "ldap_id"
    t.integer "role"
    t.string "name"
    t.string "surname"
    t.string "middle_name"
    t.integer "age"
    t.bigint "rank_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["rank_id"], name: "index_users_on_rank_id"
  end

  add_foreign_key "dispositions", "paintings"
  add_foreign_key "dispositions", "rooms"
  add_foreign_key "paintings", "painting_kinds"
  add_foreign_key "paintings", "users"
  add_foreign_key "users", "ranks"
end
