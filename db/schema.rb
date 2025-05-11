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

ActiveRecord::Schema[7.1].define(version: 2025_05_11_122805) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "creator_status", ["active", "inactive"]
  create_enum "payout_status", ["pending", "paid"]

  create_table "creators", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.enum "status", default: "active", null: false, enum_type: "creator_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payouts", force: :cascade do |t|
    t.bigint "creator_id", null: false
    t.decimal "amount"
    t.enum "status", default: "pending", null: false, enum_type: "payout_status"
    t.datetime "paid_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_payouts_on_creator_id"
  end

  add_foreign_key "payouts", "creators"
end
