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

ActiveRecord::Schema.define(version: 2019_02_03_160750) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "companies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "headquarters"
    t.string "origin_country"
    t.jsonb "external_ids"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_ids"], name: "index_companies_on_external_ids", using: :gin
  end

  create_table "credits", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "media_type"
    t.uuid "media_id"
    t.uuid "person_id"
    t.string "credit_type"
    t.string "character"
    t.string "department"
    t.string "job"
    t.jsonb "external_ids"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_ids"], name: "index_credits_on_external_ids", using: :gin
    t.index ["media_type", "media_id"], name: "index_credits_on_media_type_and_media_id"
    t.index ["person_id"], name: "index_credits_on_person_id"
  end

  create_table "images", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "media_type"
    t.uuid "media_id"
    t.boolean "primary", default: false, null: false
    t.string "image_type"
    t.string "source"
    t.string "key"
    t.integer "width"
    t.integer "height"
    t.string "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["media_type", "media_id"], name: "index_images_on_media_type_and_media_id"
    t.index ["source", "key"], name: "index_images_on_source_and_key", unique: true
  end

  create_table "media", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "parent_type"
    t.uuid "parent_id"
    t.string "type"
    t.integer "number"
    t.string "production_code"
    t.string "original_title"
    t.string "original_language"
    t.date "start_date"
    t.date "end_date"
    t.string "status"
    t.string "media_type"
    t.boolean "adult"
    t.boolean "in_production"
    t.integer "runtime"
    t.jsonb "translations"
    t.jsonb "external_ids"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["external_ids"], name: "index_media_on_external_ids", using: :gin
    t.index ["parent_type", "parent_id"], name: "index_media_on_parent_type_and_parent_id"
    t.index ["slug"], name: "index_media_on_slug", unique: true
  end

  create_table "media_credits", force: :cascade do |t|
    t.string "media_type"
    t.uuid "media_id"
    t.uuid "credit_id"
    t.integer "position"
    t.index ["credit_id"], name: "index_media_credits_on_credit_id"
    t.index ["media_type", "media_id"], name: "index_media_credits_on_media_type_and_media_id"
  end

  create_table "people", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "aka", array: true
    t.integer "gender"
    t.date "birth_date"
    t.string "birth_location"
    t.date "death_date"
    t.string "role"
    t.string "url"
    t.boolean "adult"
    t.text "biography"
    t.jsonb "external_ids"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["external_ids"], name: "index_people_on_external_ids", using: :gin
    t.index ["slug"], name: "index_people_on_slug", unique: true
  end

  create_table "seasons", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "series_id"
    t.integer "number"
    t.date "start_date"
    t.jsonb "external_ids"
    t.jsonb "translations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_ids"], name: "index_seasons_on_external_ids", using: :gin
    t.index ["series_id", "number"], name: "index_seasons_on_series_id_and_number", unique: true
    t.index ["series_id"], name: "index_seasons_on_series_id"
  end

  create_table "videos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "media_type"
    t.uuid "media_id"
    t.boolean "primary", default: false, null: false
    t.string "name"
    t.string "video_type"
    t.string "source"
    t.string "key"
    t.integer "size"
    t.string "language"
    t.jsonb "external_ids"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_ids"], name: "index_videos_on_external_ids", using: :gin
    t.index ["media_type", "media_id"], name: "index_videos_on_media_type_and_media_id"
    t.index ["source", "key"], name: "index_videos_on_source_and_key", unique: true
  end

end
