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

ActiveRecord::Schema.define(version: 2022_05_06_141247) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channels", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.boolean "is_active", default: true
    t.bigint "headquarter_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["headquarter_id"], name: "index_channels_on_headquarter_id"
  end

  create_table "channels_memberships", id: false, force: :cascade do |t|
    t.bigint "channel_id", null: false
    t.bigint "membership_id", null: false
  end

  create_table "channels_warehouses", id: false, force: :cascade do |t|
    t.bigint "channel_id", null: false
    t.bigint "warehouse_id", null: false
  end

  create_table "headquarters", force: :cascade do |t|
    t.string "brand"
    t.boolean "is_active", default: true
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_headquarters_on_user_id"
  end

  create_table "headquarters_warehouses", id: false, force: :cascade do |t|
    t.bigint "headquarter_id", null: false
    t.bigint "warehouse_id", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.datetime "expiration"
    t.boolean "autorenewal"
    t.boolean "is_active", default: true
    t.bigint "role_id", null: false
    t.bigint "user_id", null: false
    t.bigint "headquarter_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["headquarter_id"], name: "index_memberships_on_headquarter_id"
    t.index ["role_id"], name: "index_memberships_on_role_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.boolean "is_completed"
    t.bigint "membership_id", null: false
    t.bigint "channel_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["channel_id"], name: "index_orders_on_channel_id"
    t.index ["membership_id"], name: "index_orders_on_membership_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "brand"
    t.string "sku"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sales", force: :cascade do |t|
    t.integer "quantity"
    t.float "price"
    t.bigint "order_id", null: false
    t.bigint "space_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_sales_on_order_id"
    t.index ["space_id"], name: "index_sales_on_space_id"
  end

  create_table "spaces", force: :cascade do |t|
    t.integer "stock"
    t.float "price"
    t.datetime "expiration"
    t.bigint "warehouse_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_spaces_on_product_id"
    t.index ["warehouse_id"], name: "index_spaces_on_warehouse_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "warehouses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "address"
    t.boolean "is_active", default: true
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_warehouses_on_user_id"
  end

  add_foreign_key "channels", "headquarters"
  add_foreign_key "headquarters", "users"
  add_foreign_key "memberships", "headquarters"
  add_foreign_key "memberships", "roles"
  add_foreign_key "memberships", "users"
  add_foreign_key "orders", "channels"
  add_foreign_key "orders", "memberships"
  add_foreign_key "sales", "orders"
  add_foreign_key "sales", "spaces"
  add_foreign_key "spaces", "products"
  add_foreign_key "spaces", "warehouses"
  add_foreign_key "warehouses", "users"
end
