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

ActiveRecord::Schema.define(version: 2019_02_06_022652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "awards", force: :cascade do |t|
    t.string "media_type"
    t.uuid "media_id"
    t.uuid "festival_id"
    t.integer "year"
    t.string "award_type"
    t.string "award_name"
    t.index ["festival_id"], name: "index_awards_on_festival_id"
    t.index ["media_type", "media_id"], name: "index_awards_on_media_type_and_media_id"
  end

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "parent_id"
    t.string "name"
    t.string "slug"
    t.index ["parent_id"], name: "index_categories_on_parent_id"
    t.index ["slug", "parent_id"], name: "index_categories_on_slug_and_parent_id", unique: true
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

  create_table "festivals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.boolean "active", default: false, null: false
    t.uuid "season_id"
    t.string "original_title"
    t.string "original_language"
    t.string "slug"
    t.string "type"
    t.date "start_date"
    t.date "end_date"
    t.integer "runtime"
    t.string "status"
    t.string "media_type"
    t.integer "number"
    t.jsonb "translations"
    t.jsonb "extra_fields"
    t.jsonb "external_ids"
    t.jsonb "external_scores"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_ids"], name: "index_media_on_external_ids", using: :gin
    t.index ["external_scores"], name: "index_media_on_external_scores", using: :gin
    t.index ["season_id"], name: "index_media_on_season_id"
    t.index ["slug", "season_id"], name: "index_media_on_slug_and_season_id", unique: true
  end

  create_table "media_categories", force: :cascade do |t|
    t.string "media_type"
    t.uuid "media_id"
    t.uuid "category_id"
    t.index ["category_id", "media_type", "media_id"], name: "index_media_categories_on_unique", unique: true
    t.index ["category_id"], name: "index_media_categories_on_category_id"
    t.index ["media_type", "media_id"], name: "index_media_categories_on_media_type_and_media_id"
  end

  create_table "media_credits", force: :cascade do |t|
    t.string "media_type"
    t.uuid "media_id"
    t.uuid "credit_id"
    t.integer "position"
    t.index ["credit_id", "media_type", "media_id"], name: "index_media_credits_on_unique", unique: true
    t.index ["credit_id"], name: "index_media_credits_on_credit_id"
    t.index ["media_type", "media_id"], name: "index_media_credits_on_media_type_and_media_id"
  end

  create_table "media_services", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "media_type"
    t.uuid "media_id"
    t.uuid "service_id"
    t.index ["media_type", "media_id"], name: "index_media_services_on_media_type_and_media_id"
    t.index ["service_id"], name: "index_media_services_on_service_id"
  end

  create_table "people", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "aka", array: true
    t.integer "gender"
    t.date "birth_date"
    t.string "birth_location"
    t.date "death_date"
    t.string "role"
    t.text "biography"
    t.jsonb "extra_fields"
    t.jsonb "external_ids"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_ids"], name: "index_people_on_external_ids", using: :gin
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

  create_table "services", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "service_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
