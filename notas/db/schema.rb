# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110620161636) do

  create_table "signatures", :force => true do |t|
    t.string   "name",       :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "signatures_students", :force => true do |t|
    t.integer "signature_id"
    t.integer "student_id"
    t.integer "year_id"
    t.decimal "average1",      :precision => 4, :scale => 2
    t.integer "calification1"
    t.decimal "average2",      :precision => 4, :scale => 2
    t.integer "calification2"
    t.boolean "ordinary"
  end

  create_table "signatures_teachers", :id => false, :force => true do |t|
    t.integer "signature_id"
    t.integer "teacher_id"
    t.integer "year_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "type",                      :limit => 40
    t.string   "expedient",                 :limit => 40
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "years", :force => true do |t|
    t.integer  "start_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
