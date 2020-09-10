# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_10_141738) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.integer "yardage"
    t.integer "par"
    t.string "difficulty"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "star_rating"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "golfers", force: :cascade do |t|
    t.string "name"
    t.string "gamertag"
    t.decimal "handicap"
    t.integer "victories"
    t.bigint "society_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["society_id"], name: "index_golfers_on_society_id"
  end

  create_table "season_tournaments", force: :cascade do |t|
    t.integer "season_order"
    t.integer "rounds"
    t.date "start_date"
    t.date "end_date"
    t.bigint "course_id"
    t.bigint "society_id"
    t.bigint "tournament_id"
    t.bigint "season_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_season_tournaments_on_course_id"
    t.index ["season_id"], name: "index_season_tournaments_on_season_id"
    t.index ["society_id"], name: "index_season_tournaments_on_society_id"
    t.index ["tournament_id"], name: "index_season_tournaments_on_tournament_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.integer "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "society_id"
    t.string "slug"
    t.index ["slug"], name: "index_seasons_on_slug", unique: true
    t.index ["society_id"], name: "index_seasons_on_society_id"
  end

  create_table "societies", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_societies_on_name"
  end

  create_table "tournament_levels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.bigint "society_id"
    t.bigint "course_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "tournament_level_id"
    t.index ["course_id"], name: "index_tournaments_on_course_id"
    t.index ["name"], name: "index_tournaments_on_name", unique: true
    t.index ["society_id"], name: "index_tournaments_on_society_id"
    t.index ["tournament_level_id"], name: "index_tournaments_on_tournament_level_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "golfers", "societies"
  add_foreign_key "seasons", "societies"
  add_foreign_key "tournaments", "tournament_levels"
end
