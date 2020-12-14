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

ActiveRecord::Schema.define(version: 2020_12_14_033504) do

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

  create_table "event_winners", force: :cascade do |t|
    t.bigint "golfer_id"
    t.bigint "season_tournament_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "golfer_season_id"
    t.string "event_level"
    t.index ["golfer_id"], name: "index_event_winners_on_golfer_id"
    t.index ["golfer_season_id"], name: "index_event_winners_on_golfer_season_id"
    t.index ["season_tournament_id"], name: "index_event_winners_on_season_tournament_id"
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

  create_table "golfer_events", force: :cascade do |t|
    t.boolean "completed"
    t.integer "finish"
    t.integer "score"
    t.integer "score_to_par"
    t.integer "points"
    t.bigint "golfer_id"
    t.bigint "golfer_season_id"
    t.bigint "tournament_id"
    t.bigint "season_tournament_id"
    t.bigint "society_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "course_id"
    t.index ["course_id"], name: "index_golfer_events_on_course_id"
    t.index ["golfer_id"], name: "index_golfer_events_on_golfer_id"
    t.index ["golfer_season_id"], name: "index_golfer_events_on_golfer_season_id"
    t.index ["season_tournament_id"], name: "index_golfer_events_on_season_tournament_id"
    t.index ["society_id"], name: "index_golfer_events_on_society_id"
    t.index ["tournament_id"], name: "index_golfer_events_on_tournament_id"
  end

  create_table "golfer_rounds", force: :cascade do |t|
    t.integer "round_order"
    t.integer "score"
    t.integer "score_to_par"
    t.bigint "golfer_id"
    t.bigint "golfer_event_id"
    t.bigint "course_id"
    t.bigint "tournament_id"
    t.bigint "season_tournament_id"
    t.bigint "society_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "golfer_season_id"
    t.index ["course_id"], name: "index_golfer_rounds_on_course_id"
    t.index ["golfer_event_id"], name: "index_golfer_rounds_on_golfer_event_id"
    t.index ["golfer_id"], name: "index_golfer_rounds_on_golfer_id"
    t.index ["golfer_season_id"], name: "index_golfer_rounds_on_golfer_season_id"
    t.index ["season_tournament_id"], name: "index_golfer_rounds_on_season_tournament_id"
    t.index ["society_id"], name: "index_golfer_rounds_on_society_id"
    t.index ["tournament_id"], name: "index_golfer_rounds_on_tournament_id"
  end

  create_table "golfer_seasons", force: :cascade do |t|
    t.integer "year"
    t.integer "events"
    t.integer "wins"
    t.integer "points"
    t.boolean "champion"
    t.bigint "golfer_id"
    t.bigint "season_id"
    t.bigint "society_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "rank"
    t.index ["golfer_id"], name: "index_golfer_seasons_on_golfer_id"
    t.index ["season_id"], name: "index_golfer_seasons_on_season_id"
    t.index ["society_id"], name: "index_golfer_seasons_on_society_id"
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

  create_table "headlines", force: :cascade do |t|
    t.text "story"
    t.string "importance"
    t.date "story_date"
    t.date "expiration_date"
    t.bigint "golfer_id"
    t.bigint "season_tournament_id"
    t.bigint "society_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["golfer_id"], name: "index_headlines_on_golfer_id"
    t.index ["season_tournament_id"], name: "index_headlines_on_season_tournament_id"
    t.index ["society_id"], name: "index_headlines_on_society_id"
  end

  create_table "match_play_matchups", force: :cascade do |t|
    t.integer "favorite_golfer_id"
    t.integer "underdog_golfer_id"
    t.integer "round"
    t.integer "favorite_seed"
    t.integer "underdog_seed"
    t.integer "strokes_up"
    t.integer "holes_to_play"
    t.integer "winner_golfer_id"
    t.bigint "season_tournament_id"
    t.boolean "final"
    t.integer "winner_place"
    t.integer "loser_place"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "loser_golfer_id"
    t.boolean "losers_bracket", default: false
    t.index ["season_tournament_id"], name: "index_match_play_matchups_on_season_tournament_id"
  end

  create_table "records", force: :cascade do |t|
    t.string "name"
    t.decimal "value", precision: 7, scale: 2
    t.date "date"
    t.bigint "golfer_id"
    t.bigint "golfer_event_id"
    t.bigint "season_tournament_id"
    t.bigint "society_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "decimal_places"
    t.boolean "to_par"
    t.index ["golfer_event_id"], name: "index_records_on_golfer_event_id"
    t.index ["golfer_id"], name: "index_records_on_golfer_id"
    t.index ["name"], name: "index_records_on_name"
    t.index ["season_tournament_id"], name: "index_records_on_season_tournament_id"
    t.index ["society_id"], name: "index_records_on_society_id"
  end

  create_table "ryder_cup_appearances", force: :cascade do |t|
    t.bigint "golfer_id"
    t.bigint "ryder_cup_team_id"
    t.boolean "captain"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["golfer_id"], name: "index_ryder_cup_appearances_on_golfer_id"
    t.index ["ryder_cup_team_id"], name: "index_ryder_cup_appearances_on_ryder_cup_team_id"
  end

  create_table "ryder_cup_rounds", force: :cascade do |t|
    t.bigint "ryder_cup_session_id"
    t.integer "europe_golfer_one_id"
    t.integer "europe_golfer_two_id"
    t.integer "usa_golfer_one_id"
    t.integer "usa_golfer_two_id"
    t.integer "europe_score"
    t.integer "usa_score"
    t.decimal "europe_points"
    t.decimal "usa_points"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ryder_cup_session_id"], name: "index_ryder_cup_rounds_on_ryder_cup_session_id"
  end

  create_table "ryder_cup_sessions", force: :cascade do |t|
    t.bigint "ryder_cup_id"
    t.string "scoring_type"
    t.decimal "team_europe_score"
    t.decimal "team_usa_score"
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "course_id"
    t.boolean "finalized", default: false
    t.index ["course_id"], name: "index_ryder_cup_sessions_on_course_id"
    t.index ["ryder_cup_id"], name: "index_ryder_cup_sessions_on_ryder_cup_id"
  end

  create_table "ryder_cup_teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ryder_cups", force: :cascade do |t|
    t.bigint "season_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "team_europe_id"
    t.integer "team_usa_id"
    t.integer "champion"
    t.string "name"
    t.index ["champion"], name: "index_ryder_cups_on_champion"
    t.index ["season_id"], name: "index_ryder_cups_on_season_id"
    t.index ["team_europe_id"], name: "index_ryder_cups_on_team_europe_id"
    t.index ["team_usa_id"], name: "index_ryder_cups_on_team_usa_id"
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
    t.boolean "finalized", default: false
    t.string "event_level"
    t.boolean "match_play", default: false
    t.integer "current_round", default: 0
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
    t.integer "champion_id"
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
    t.string "updated_name"
    t.integer "name_updated_year"
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
