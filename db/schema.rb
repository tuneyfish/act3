# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110925011504) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "car_owners", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", :force => true do |t|
    t.datetime "purchased_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.string   "type"
    t.string   "business_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.string   "phone_number"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "distributor_brands", :force => true do |t|
    t.integer  "distributor_id"
    t.integer  "brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "distributor_quotes", :force => true do |t|
    t.integer  "distributor_id"
    t.integer  "price_quote_id"
    t.decimal  "price",          :precision => 8, :scale => 2, :default => 0.0
    t.boolean  "accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "requested_at"
    t.datetime "received_at"
  end

  create_table "distributors", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "key"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string   "sku"
    t.string   "tracking_number"
    t.integer  "quantity"
    t.integer  "item_price"
    t.integer  "item_tax"
    t.integer  "shipping_price"
    t.integer  "shipping_tax"
    t.integer  "cart_id"
    t.integer  "order_id"
    t.integer  "part_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status_id"
    t.string   "item_key"
    t.integer  "person_id"
    t.decimal  "base_price",      :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "base_ship_price", :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "sale_price",      :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "sale_ship_price", :precision => 8, :scale => 2, :default => 0.0
    t.integer  "car_id"
    t.integer  "distributor_id"
  end

  create_table "mechanics", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_reports", :force => true do |t|
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_transactions", :force => true do |t|
    t.integer  "order_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
    t.integer  "distributor_id"
    t.integer  "action_id"
  end

  create_table "orders", :force => true do |t|
    t.string   "status"
    t.string   "tracking_number"
    t.string   "order_id"
    t.integer  "order_report_id"
    t.string   "order_item_id"
    t.datetime "purchase_date"
    t.string   "buyer_email"
    t.string   "buyer_name"
    t.string   "recipient_name"
    t.string   "ship_address_1"
    t.string   "ship_address_2"
    t.string   "ship_address_3"
    t.string   "ship_city"
    t.string   "ship_state"
    t.string   "ship_postal_code"
    t.string   "ship_country"
    t.string   "ship_phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cart_id"
    t.string   "ip_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "card_type"
    t.date     "card_expires_on"
    t.string   "bill_address_1"
    t.string   "bill_address_2"
    t.string   "bill_city"
    t.string   "bill_state"
    t.string   "bill_postal_code"
    t.string   "bill_country"
    t.string   "bill_phone_number"
    t.string   "bill_first_name"
    t.string   "bill_last_name"
    t.string   "ship_first_name"
    t.string   "ship_last_name"
    t.integer  "status_id"
    t.string   "ext_id"
    t.string   "type"
    t.string   "customer_id"
    t.integer  "person_id"
    t.text     "notes"
    t.integer  "source"
  end

  create_table "part_categories", :force => true do |t|
    t.integer  "part_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "part_distributors", :force => true do |t|
    t.integer  "part_id"
    t.integer  "distributor_id"
    t.decimal  "price",          :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parts", :force => true do |t|
    t.string   "sku"
    t.string   "manufacturer_name"
    t.string   "name"
    t.string   "part_number"
    t.string   "description"
    t.decimal  "price",               :precision => 8,  :scale => 2, :default => 0.0
    t.decimal  "ship",                :precision => 8,  :scale => 2, :default => 0.0
    t.string   "image"
    t.integer  "brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "originator_site"
    t.decimal  "originator_price",    :precision => 8,  :scale => 2, :default => 0.0
    t.integer  "parts_report_id"
    t.decimal  "MSRPPrice",           :precision => 8,  :scale => 2, :default => 0.0
    t.decimal  "MAPPrice",            :precision => 8,  :scale => 2, :default => 0.0
    t.decimal  "JobberPrice",         :precision => 8,  :scale => 2, :default => 0.0
    t.decimal  "DetroitTurboPrice",   :precision => 8,  :scale => 2, :default => 0.0
    t.decimal  "weight",              :precision => 10, :scale => 0
    t.string   "unit_of_measure"
    t.integer  "quantity"
    t.string   "premier_part_number"
    t.boolean  "published",                                          :default => false
    t.boolean  "in_stock",                                           :default => false
    t.boolean  "drop_ship",                                          :default => false
  end

  create_table "parts_20090531_backup", :force => true do |t|
    t.string   "sku"
    t.string   "manufacturer_name"
    t.string   "name"
    t.string   "part_number"
    t.string   "description"
    t.decimal  "price",             :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "ship",              :precision => 8, :scale => 2, :default => 0.0
    t.string   "image"
    t.integer  "brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "originator_site"
    t.decimal  "originator_price",  :precision => 8, :scale => 2, :default => 0.0
    t.integer  "parts_report_id"
  end

  create_table "parts_reports", :force => true do |t|
    t.string   "filepath"
    t.integer  "rows_parsed"
    t.integer  "new_parts"
    t.integer  "dup_parts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "type"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.string   "phone_number"
    t.string   "mobile_number"
    t.string   "fax_number"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "car_make"
    t.string   "car_model"
    t.string   "car_year"
  end

  create_table "price_quote_requests", :force => true do |t|
    t.integer  "part_id"
    t.integer  "distributor_id"
    t.decimal  "price_quote",              :precision => 8, :scale => 2, :default => 0.0
    t.datetime "price_quote_requested_at"
    t.datetime "price_quote_received_at"
    t.boolean  "chosen_quote"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_quotes", :force => true do |t|
    t.string   "brand"
    t.string   "part_name"
    t.string   "part_number"
    t.integer  "part_id"
    t.integer  "part_grade"
    t.string   "customer_name"
    t.string   "email"
    t.string   "postal_code"
    t.string   "country"
    t.string   "phone_number"
    t.decimal  "target_price",   :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "shipping_price", :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "quoted_price",   :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
    t.text     "notes"
  end

  create_table "shops", :force => true do |t|
    t.string   "name"
    t.string   "make"
    t.string   "affiliations"
    t.string   "specialties"
    t.string   "amenities"
    t.string   "phone_number"
    t.string   "fax_number"
    t.string   "email"
    t.string   "website"
    t.string   "raw_address"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "postal_code"
    t.string   "lat"
    t.string   "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "touches", :force => true do |t|
    t.text     "notes"
    t.text     "process_notes"
    t.integer  "in_out"
    t.integer  "people_id"
    t.integer  "touch_group_id"
    t.integer  "category"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
