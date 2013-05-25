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

ActiveRecord::Schema.define(:version => 2013052500050500) do

  create_table "adminusers", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "adminusers", ["email"], :name => "index_adminusers_on_email", :unique => true
  add_index "adminusers", ["reset_password_token"], :name => "index_adminusers_on_reset_password_token", :unique => true

  create_table "linkmaincats", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "linkmaincats_links", :id => false, :force => true do |t|
    t.integer "linkmaincat_id"
    t.integer "link_id"
  end

  add_index "linkmaincats_links", ["linkmaincat_id", "link_id"], :name => "index_linkmaincats_links_on_linkmaincat_id_and_link_id"

  create_table "linkpagecats", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "linkpagecats_links", :id => false, :force => true do |t|
    t.integer "linkpagecat_id"
    t.integer "link_id"
  end

  add_index "linkpagecats_links", ["linkpagecat_id", "link_id"], :name => "index_linkpagecats_links_on_linkpagecat_id_and_link_id"

  create_table "links", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "description"
    t.boolean  "published",   :default => true
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "links_linksubcats", :id => false, :force => true do |t|
    t.integer "linksubcat_id"
    t.integer "link_id"
  end

  add_index "links_linksubcats", ["linksubcat_id", "link_id"], :name => "index_links_linksubcats_on_linksubcat_id_and_link_id"

  create_table "linksubcats", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notifications", :force => true do |t|
    t.string   "uid"
    t.text     "data"
    t.text     "translator"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.datetime "occurred_at"
  end

  add_index "notifications", ["occurred_at"], :name => "index_notifications_on_occurred_at"
  add_index "notifications", ["uid"], :name => "index_notifications_on_uid"

  create_table "oauth2_data", :force => true do |t|
    t.string  "uid"
    t.string  "app_id"
    t.text    "access_token"
    t.text    "refresh_token"
    t.integer "expiration_time", :limit => 8
    t.text    "app_data"
  end

  add_index "oauth2_data", ["uid", "app_id"], :name => "index_oauth2_data_on_uid_app_id", :unique => true

  create_table "oracle_databases", :id => false, :force => true do |t|
    t.date "temp"
  end

  create_table "user_auths", :force => true do |t|
    t.string   "uid",                             :null => false
    t.boolean  "is_superuser", :default => false, :null => false
    t.boolean  "is_test_user", :default => false, :null => false
    t.boolean  "active",       :default => false, :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "user_auths", ["uid"], :name => "index_user_auths_on_uid", :unique => true

  create_table "user_data", :force => true do |t|
    t.string   "uid"
    t.string   "preferred_name"
    t.datetime "first_login_at"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "user_data", ["uid"], :name => "index_user_data_on_uid", :unique => true

  create_table "user_visits", :id => false, :force => true do |t|
    t.string   "uid",           :null => false
    t.datetime "last_visit_at", :null => false
  end

  add_index "user_visits", ["last_visit_at"], :name => "index_user_visits_on_last_visit_at"
  add_index "user_visits", ["uid"], :name => "index_user_visits_on_uid", :unique => true

end
