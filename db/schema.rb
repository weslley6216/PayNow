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

ActiveRecord::Schema.define(version: 2021_06_18_050732) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "bank_slips", force: :cascade do |t|
    t.string "bank_number"
    t.string "agency_number"
    t.string "account_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "payment_method_id", null: false
    t.integer "company_id", null: false
    t.index ["company_id"], name: "index_bank_slips_on_company_id"
    t.index ["payment_method_id"], name: "index_bank_slips_on_payment_method_id"
  end

  create_table "charges", force: :cascade do |t|
    t.decimal "original_value"
    t.decimal "discounted_amount"
    t.string "token"
    t.integer "status", default: 1
    t.string "card_number"
    t.string "card_holder_name"
    t.string "cvv"
    t.string "address"
    t.string "district"
    t.string "zip_code"
    t.string "city"
    t.integer "payment_method_id", null: false
    t.integer "bank_slip_id"
    t.integer "credit_card_id"
    t.integer "pix_id"
    t.integer "company_id", null: false
    t.integer "final_client_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bank_slip_id"], name: "index_charges_on_bank_slip_id"
    t.index ["company_id"], name: "index_charges_on_company_id"
    t.index ["credit_card_id"], name: "index_charges_on_credit_card_id"
    t.index ["final_client_id"], name: "index_charges_on_final_client_id"
    t.index ["payment_method_id"], name: "index_charges_on_payment_method_id"
    t.index ["pix_id"], name: "index_charges_on_pix_id"
    t.index ["product_id"], name: "index_charges_on_product_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "corporate_name"
    t.string "cnpj"
    t.string "billing_address"
    t.string "billing_email"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string "credit_code"
    t.integer "payment_method_id", null: false
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_credit_cards_on_company_id"
    t.index ["payment_method_id"], name: "index_credit_cards_on_payment_method_id"
  end

  create_table "final_client_companies", force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "final_client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_final_client_companies_on_company_id"
    t.index ["final_client_id"], name: "index_final_client_companies_on_final_client_id"
  end

  create_table "final_clients", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "token"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.decimal "tax"
    t.decimal "max_tax"
    t.boolean "status", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "form_of_payment", null: false
  end

  create_table "pixes", force: :cascade do |t|
    t.string "bank_number"
    t.string "pix_key"
    t.integer "payment_method_id", null: false
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_pixes_on_company_id"
    t.index ["payment_method_id"], name: "index_pixes_on_payment_method_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.decimal "bank_slip_discount", default: "0.0"
    t.decimal "credit_card_discount", default: "0.0"
    t.decimal "pix_discount", default: "0.0"
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "token"
    t.index ["company_id"], name: "index_products_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bank_slips", "companies"
  add_foreign_key "bank_slips", "payment_methods"
  add_foreign_key "charges", "bank_slips"
  add_foreign_key "charges", "companies"
  add_foreign_key "charges", "credit_cards"
  add_foreign_key "charges", "final_clients"
  add_foreign_key "charges", "payment_methods"
  add_foreign_key "charges", "pixes"
  add_foreign_key "charges", "products"
  add_foreign_key "credit_cards", "companies"
  add_foreign_key "credit_cards", "payment_methods"
  add_foreign_key "final_client_companies", "companies"
  add_foreign_key "final_client_companies", "final_clients"
  add_foreign_key "pixes", "companies"
  add_foreign_key "pixes", "payment_methods"
  add_foreign_key "products", "companies"
  add_foreign_key "users", "companies"
end
