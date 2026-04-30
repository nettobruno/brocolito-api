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

ActiveRecord::Schema[8.1].define(version: 2026_04_30_030752) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "body_measurements", force: :cascade do |t|
    t.decimal "abdomen_circumference_cm"
    t.decimal "calf_circumference_cm"
    t.decimal "chest_circumference_cm"
    t.datetime "created_at", null: false
    t.decimal "flexed_arm_circumference_cm"
    t.decimal "forearm_circumference_cm"
    t.integer "height_cm"
    t.decimal "hip_circumference_cm"
    t.decimal "neck_circumference_cm"
    t.decimal "relaxed_arm_circumference_cm"
    t.decimal "shoulder_circumference_cm"
    t.decimal "thigh_circumference_cm"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.decimal "waist_circumference_cm"
    t.decimal "weight_kg"
    t.index ["user_id"], name: "index_body_measurements_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "body_measurements", "users"
end
