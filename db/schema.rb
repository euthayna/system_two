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

ActiveRecord::Schema[7.2].define(version: 2025_01_31_054223) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "client_id"
    t.string "client_secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "product_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.string "status", default: "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_contracts_on_product_id"
    t.index ["tenant_id"], name: "index_contracts_on_tenant_id"
  end

  create_table "monthly_resource_consumptions", force: :cascade do |t|
    t.bigint "tenant_id"
    t.bigint "product_id"
    t.decimal "total_used", default: "0.0", null: false
    t.string "use_unity", null: false
    t.decimal "total_cost", null: false
    t.string "interval", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_monthly_resource_consumptions_on_product_id"
    t.index ["tenant_id"], name: "index_monthly_resource_consumptions_on_tenant_id"
  end

  create_table "pricings", force: :cascade do |t|
    t.bigint "product_id"
    t.decimal "price_per_unit", null: false
    t.string "currency", default: "BRL", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_pricings_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "use_unity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tenants", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name"
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "contracts", "products"
  add_foreign_key "contracts", "tenants"
  add_foreign_key "monthly_resource_consumptions", "products"
  add_foreign_key "monthly_resource_consumptions", "tenants"
  add_foreign_key "pricings", "products"
end
