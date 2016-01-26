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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160122210510) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delphis", force: :cascade do |t|
    t.string   "username",        null: false
    t.integer  "workpackage_id"
    t.integer  "value"
    t.string   "workpackagename"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "delphis", ["workpackage_id"], name: "index_delphis_on_workpackage_id", using: :btree

  create_table "nodes", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "level"
    t.integer  "duration"
    t.date     "startdate"
    t.date     "enddate"
    t.boolean  "milestone"
    t.integer  "project_id"
    t.integer  "parent_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "nodes", ["parent_id"], name: "index_nodes_on_parent_id", using: :btree
  add_index "nodes", ["project_id"], name: "index_nodes_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.date     "startdate"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ram_roles", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "ram_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ram_roles", ["ram_id"], name: "index_ram_roles_on_ram_id", using: :btree
  add_index "ram_roles", ["role_id"], name: "index_ram_roles_on_role_id", using: :btree

  create_table "rams", force: :cascade do |t|
    t.integer  "workpackage_id"
    t.integer  "node_id"
    t.integer  "project_id"
    t.integer  "level"
    t.integer  "order"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "rams", ["node_id"], name: "index_rams_on_node_id", using: :btree
  add_index "rams", ["project_id"], name: "index_rams_on_project_id", using: :btree
  add_index "rams", ["workpackage_id"], name: "index_rams_on_workpackage_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "qualification"
    t.text     "experience"
    t.integer  "quantity"
    t.integer  "level"
    t.integer  "project_id"
    t.integer  "parent_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "roles", ["parent_id"], name: "index_roles_on_parent_id", using: :btree
  add_index "roles", ["project_id"], name: "index_roles_on_project_id", using: :btree

  create_table "workpackages", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "result"
    t.text     "interfaces"
    t.string   "purchaser"
    t.integer  "level"
    t.integer  "duration"
    t.date     "startdate"
    t.date     "enddate"
    t.text     "activities"
    t.text     "requirements"
    t.decimal  "costs"
    t.integer  "work"
    t.decimal  "workPerformed", default: 0.0
    t.integer  "project_id"
    t.integer  "parent_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "workpackages", ["parent_id"], name: "index_workpackages_on_parent_id", using: :btree
  add_index "workpackages", ["project_id"], name: "index_workpackages_on_project_id", using: :btree

  add_foreign_key "delphis", "workpackages"
  add_foreign_key "nodes", "projects"
  add_foreign_key "ram_roles", "rams"
  add_foreign_key "ram_roles", "roles"
  add_foreign_key "rams", "nodes"
  add_foreign_key "rams", "projects"
  add_foreign_key "rams", "workpackages"
  add_foreign_key "roles", "projects"
  add_foreign_key "workpackages", "projects"
end
