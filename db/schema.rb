# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_14_165019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer "addressable_id"
    t.string "addressable_type"
    t.string "street"
    t.string "city"
    t.string "province"
    t.string "zip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "owner_id"
    t.date "event_date"
    t.time "event_time"
  end

  create_table "invitations", force: :cascade do |t|
    t.string "email"
    t.integer "event_id"
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 10
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.datetime "join_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role", default: 10, null: false
    t.index ["event_id"], name: "index_memberships_on_event_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "tokens", force: :cascade do |t|
    t.string "value"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "ownerable_id"
    t.string "ownerable_type"
    t.index ["value"], name: "index_tokens_on_value"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "confirmed", default: false
    t.string "type"
    t.string "name"
    t.string "surname"
    t.text "short_bio"
    t.date "birth_date"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
