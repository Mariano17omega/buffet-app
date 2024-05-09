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

ActiveRecord::Schema[7.1].define(version: 2024_05_08_184120) do
  create_table "buffets", force: :cascade do |t|
    t.string "brand_name"
    t.string "corporate_name"
    t.string "cnpj"
    t.string "contact_phone"
    t.string "contact_email"
    t.string "address"
    t.string "district"
    t.string "state"
    t.string "city"
    t.string "cep"
    t.string "description"
    t.integer "user_owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_owner_id"], name: "index_buffets_on_user_owner_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "min_guests"
    t.integer "max_guests"
    t.integer "duration"
    t.string "menu"
    t.boolean "alcoholic_beverages"
    t.boolean "decoration"
    t.boolean "parking_servise"
    t.boolean "event_location"
    t.integer "buffet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_events_on_buffet_id"
  end

  create_table "orders", force: :cascade do |t|
    t.date "date_event"
    t.integer "num_guests"
    t.string "code"
    t.string "details"
    t.string "address_event"
    t.integer "status", default: 0
    t.integer "user_client_id", null: false
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_orders_on_event_id"
    t.index ["user_client_id"], name: "index_orders_on_user_client_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.boolean "cash"
    t.boolean "credit_card"
    t.boolean "debit_card"
    t.boolean "bank_transfer"
    t.boolean "paypal"
    t.boolean "check"
    t.boolean "pix"
    t.boolean "bitcoin"
    t.boolean "google_pay"
    t.integer "buffet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_payment_methods_on_buffet_id"
  end

  create_table "prices", force: :cascade do |t|
    t.float "price_base_weekdays"
    t.float "price_add_weekdays"
    t.float "price_overtime_weekdays"
    t.float "price_base_weekend"
    t.float "price_add_weekend"
    t.float "price_overtime_weekend"
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_prices_on_event_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.integer "user_client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_client_id"], name: "index_profiles_on_user_client_id"
  end

  create_table "user_clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_user_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_user_clients_on_reset_password_token", unique: true
  end

  create_table "user_owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_user_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_user_owners_on_reset_password_token", unique: true
  end

  add_foreign_key "buffets", "user_owners"
  add_foreign_key "events", "buffets"
  add_foreign_key "orders", "events"
  add_foreign_key "orders", "user_clients"
  add_foreign_key "payment_methods", "buffets"
  add_foreign_key "prices", "events"
  add_foreign_key "profiles", "user_clients"
end
