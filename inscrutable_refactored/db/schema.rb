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

ActiveRecord::Schema.define(version: 9) do

  create_table "games", force: :cascade do |t|
    t.integer "match_id"
    t.datetime "finish_time"
    t.string "result"
    t.integer "remaining_moves", default: 4
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "board_0", default: 1
    t.integer "board_1", default: 2
    t.integer "board_2", default: 3
    t.integer "board_3", default: 4
    t.integer "board_4", default: 5
    t.integer "board_5", default: 6
    t.integer "board_6", default: 7
    t.integer "board_7", default: 8
    t.integer "board_8", default: 9
  end

  create_table "matches", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "finish_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "keep_playing", default: true
  end

  create_table "moves", force: :cascade do |t|
    t.integer "game_id"
    t.string "move_type"
    t.integer "shift"
    t.integer "swap_1"
    t.integer "swap_2"
    t.integer "jump_first_piece"
    t.integer "jump_number_of_pieces"
    t.integer "jump_places"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "start_board_0"
    t.integer "start_board_1"
    t.integer "start_board_2"
    t.integer "start_board_3"
    t.integer "start_board_4"
    t.integer "start_board_5"
    t.integer "start_board_6"
    t.integer "start_board_7"
    t.integer "start_board_8"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "motto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
