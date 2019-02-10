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

ActiveRecord::Schema.define(version: 2019_02_10_102321) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "awards", force: :cascade do |t|
    t.bigint "movie_id"
    t.bigint "festival_id"
    t.integer "year"
    t.string "award_type"
    t.string "award_name"
    t.index ["festival_id"], name: "index_awards_on_festival_id"
    t.index ["movie_id"], name: "index_awards_on_movie_id"
  end

  create_table "categories", force: :cascade do |t|
    t.bigint "parent_id"
    t.string "name"
    t.string "code"
    t.index ["parent_id"], name: "index_categories_on_parent_id"
  end

  create_table "credits", force: :cascade do |t|
    t.string "media_type"
    t.bigint "media_id"
    t.bigint "person_id"
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

  create_table "episodes", force: :cascade do |t|
    t.bigint "series_id"
    t.bigint "season_id"
    t.string "slug"
    t.date "release_date"
    t.integer "season_number"
    t.integer "number"
    t.jsonb "translations"
    t.jsonb "extra_fields"
    t.jsonb "external_ids"
    t.jsonb "external_scores"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_ids"], name: "index_episodes_on_external_ids", using: :gin
    t.index ["external_scores"], name: "index_episodes_on_external_scores", using: :gin
    t.index ["season_id"], name: "index_episodes_on_season_id"
    t.index ["series_id", "season_id", "number"], name: "index_episodes_on_series_id_and_season_id_and_number", unique: true
    t.index ["series_id"], name: "index_episodes_on_series_id"
    t.index ["slug", "series_id"], name: "index_episodes_on_slug_and_series_id", unique: true
  end

  create_table "festivals", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "media", force: :cascade do |t|
    t.string "type"
    t.boolean "active", default: false, null: false
    t.string "slug"
    t.date "release_date"
    t.string "status"
    t.tsvector "tsv_title"
    t.jsonb "translations"
    t.jsonb "extra_fields"
    t.jsonb "external_ids"
    t.jsonb "external_scores"
    t.string "import_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_ids"], name: "index_media_on_external_ids", using: :gin
    t.index ["external_scores"], name: "index_media_on_external_scores", using: :gin
    t.index ["slug", "type"], name: "index_media_on_slug_and_type", unique: true
    t.index ["tsv_title"], name: "index_media_on_tsv_title", using: :gin
  end

  create_table "media_categories", force: :cascade do |t|
    t.string "media_type"
    t.bigint "media_id"
    t.bigint "category_id"
    t.index ["category_id", "media_type", "media_id"], name: "index_media_categories_on_unique", unique: true
    t.index ["category_id"], name: "index_media_categories_on_category_id"
    t.index ["media_type", "media_id"], name: "index_media_categories_on_media_type_and_media_id"
  end

  create_table "media_credits", force: :cascade do |t|
    t.string "media_type"
    t.bigint "media_id"
    t.bigint "credit_id"
    t.integer "position"
    t.index ["credit_id", "media_type", "media_id"], name: "index_media_credits_on_unique", unique: true
    t.index ["credit_id"], name: "index_media_credits_on_credit_id"
    t.index ["media_type", "media_id"], name: "index_media_credits_on_media_type_and_media_id"
  end

  create_table "people", force: :cascade do |t|
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

  create_table "seasons", force: :cascade do |t|
    t.bigint "series_id"
    t.integer "number"
    t.date "release_date"
    t.jsonb "extra_fields"
    t.jsonb "external_ids"
    t.jsonb "translations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_ids"], name: "index_seasons_on_external_ids", using: :gin
    t.index ["series_id", "number"], name: "index_seasons_on_series_id_and_number", unique: true
    t.index ["series_id"], name: "index_seasons_on_series_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "role", default: "user", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
