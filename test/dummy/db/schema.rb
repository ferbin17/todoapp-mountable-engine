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

ActiveRecord::Schema.define(version: 2020_10_25_043138) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "todoapp_comments", force: :cascade do |t|
    t.string "body"
    t.bigint "todoapp_todo_id"
    t.bigint "todoapp_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["todoapp_todo_id"], name: "index_todoapp_comments_on_todoapp_todo_id"
    t.index ["todoapp_user_id"], name: "index_todoapp_comments_on_todoapp_user_id"
  end

  create_table "todoapp_shares", force: :cascade do |t|
    t.bigint "todoapp_todo_id"
    t.bigint "todoapp_user_id"
    t.bigint "position", default: 0, null: false
    t.boolean "is_owner", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["todoapp_todo_id"], name: "index_todoapp_shares_on_todoapp_todo_id"
    t.index ["todoapp_user_id"], name: "index_todoapp_shares_on_todoapp_user_id"
  end

  create_table "todoapp_todos", force: :cascade do |t|
    t.string "body"
    t.datetime "datetime"
    t.bigint "completion_status", default: 0, null: false
    t.boolean "active", default: true
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "todoapp_user_details", force: :cascade do |t|
    t.integer "user_id"
    t.string "full_name"
    t.string "email_id"
    t.string "phone_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "todoapp_users", force: :cascade do |t|
    t.string "username"
    t.string "email_id"
    t.string "password_salt"
    t.string "hashed_password"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer "failed_attempts", default: 0
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "phone_no"
    t.integer "user_detail_id"
    t.boolean "is_admin", default: false
    t.boolean "is_seller", default: false
    t.boolean "is_active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email_id"], name: "index_todoapp_users_on_email_id"
    t.index ["reset_password_token"], name: "index_todoapp_users_on_reset_password_token"
    t.index ["unlock_token"], name: "index_todoapp_users_on_unlock_token"
    t.index ["username"], name: "index_todoapp_users_on_username"
  end

end
