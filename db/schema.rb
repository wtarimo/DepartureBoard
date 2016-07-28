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

ActiveRecord::Schema.define(version: 20160727000745) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departures", force: :cascade do |t|
    t.integer  "trip_id"
    t.integer  "lateness",      default: 0
    t.integer  "track_id"
    t.text     "info"
    t.integer  "status_id"
    t.datetime "scheduledtime"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "departures", ["status_id"], name: "index_departures_on_status_id", using: :btree
  add_index "departures", ["track_id"], name: "index_departures_on_track_id", using: :btree
  add_index "departures", ["trip_id"], name: "index_departures_on_trip_id", using: :btree

  create_table "stations", force: :cascade do |t|
    t.string   "name"
    t.text     "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "given"
    t.text     "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.integer  "number"
    t.text     "info"
    t.integer  "station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tracks", ["station_id"], name: "index_tracks_on_station_id", using: :btree

  create_table "trips", force: :cascade do |t|
    t.string   "number"
    t.integer  "origin_id"
    t.integer  "destination_id"
    t.text     "info"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_foreign_key "departures", "statuses"
  add_foreign_key "departures", "tracks"
  add_foreign_key "departures", "trips"
  add_foreign_key "tracks", "stations"
end
