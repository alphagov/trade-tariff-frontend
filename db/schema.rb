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

ActiveRecord::Schema.define(:version => 20120518150431) do

  create_table "chapters", :force => true do |t|
    t.integer  "section_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "code"
    t.text     "description"
  end

  create_table "commodities", :force => true do |t|
    t.integer  "hier_pos"
    t.integer  "substring"
    t.string   "code"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
    t.integer  "heading_id"
  end

  add_index "commodities", ["code"], :name => "index_commodities_on_code"
  add_index "commodities", ["heading_id"], :name => "index_commodities_on_heading_id"

  create_table "headings", :force => true do |t|
    t.integer  "chapter_id"
    t.string   "description"
    t.integer  "hier_pos"
    t.string   "substring"
    t.string   "code"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "headings", ["code"], :name => "index_headings_on_code"

  create_table "sections", :force => true do |t|
    t.integer  "position"
    t.string   "numeral"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
