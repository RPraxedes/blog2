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

ActiveRecord::Schema.define(version: 2019_08_20_090840) do

  create_table "chef_profiles", force: :cascade do |t|
    t.string "chefname"
    t.string "email"
  end

  create_table "chef_recipes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "chef_profile_id"
  end

  create_table "chef_users", force: :cascade do |t|
    t.string "name"
    t.string "email"
  end

  create_table "users", force: :cascade do |t|
  end

end
