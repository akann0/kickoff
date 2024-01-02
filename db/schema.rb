# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_12_15_232003) do
  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string "commenter"
    t.text "body"
    t.integer "article_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_comments_on_article_id"
  end

  create_table "gamelogs", force: :cascade do |t|
    t.integer "goals"
    t.integer "assists"
    t.string "status"
    t.integer "fpoints"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "player_id", null: false
    t.integer "irlgame_id", null: false
    t.integer "shots"
    t.integer "shots_on_goal"
    t.integer "dribbles"
    t.integer "dribbles_attempted"
    t.integer "passes_attempted"
    t.integer "passes_completed"
    t.integer "key_passes"
    t.integer "crosses"
    t.integer "crosses_attempted"
    t.integer "long_balls"
    t.integer "long_balls_attempted"
    t.integer "tackles"
    t.integer "interceptions"
    t.integer "blocks"
    t.integer "clearances"
    t.integer "error_lead_to_shot"
    t.integer "error_lead_to_goal"
    t.integer "penalty_committed"
    t.integer "ground_duels_won"
    t.integer "ground_duels"
    t.integer "aerial_duels_won"
    t.integer "aerial_duels"
    t.integer "possession_lost"
    t.integer "fouls"
    t.integer "was_fouled"
    t.integer "offsides"
    t.integer "saves"
    t.integer "goals_prevented"
    t.integer "minutes_played"
    t.index ["irlgame_id"], name: "index_gamelogs_on_irlgame_id"
    t.index ["player_id"], name: "index_gamelogs_on_player_id"
  end

  create_table "irlgames", force: :cascade do |t|
    t.integer "irlleague_id", null: false
    t.string "home"
    t.string "away"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "gamestart"
    t.string "url"
    t.integer "home_score"
    t.integer "away_score"
    t.index ["irlleague_id"], name: "index_irlgames_on_irlleague_id"
  end

  create_table "irlleagues", force: :cascade do |t|
    t.string "url"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "teamurls"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "position"
    t.integer "team_id", null: false
    t.string "nationality"
    t.string "rlteam"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "sofaid"
    t.integer "irlleague_id", null: false
    t.index ["irlleague_id"], name: "index_players_on_irlleague_id"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "manager"
    t.string "name"
    t.integer "wins"
    t.integer "losses"
    t.integer "draws"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comments", "articles"
  add_foreign_key "gamelogs", "irlgames"
  add_foreign_key "gamelogs", "players"
  add_foreign_key "irlgames", "irlleagues"
  add_foreign_key "players", "irlleagues"
  add_foreign_key "players", "teams"
end
