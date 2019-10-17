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

ActiveRecord::Schema.define(version: 2019_10_17_165252) do

  create_table "candidate_notes", force: :cascade do |t|
    t.string "comment"
    t.integer "employee_id", null: false
    t.integer "candidate_id", null: false
    t.integer "visibility", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["candidate_id"], name: "index_candidate_notes_on_candidate_id"
    t.index ["employee_id"], name: "index_candidate_notes_on_employee_id"
  end

  create_table "candidate_profiles", force: :cascade do |t|
    t.text "work_experience"
    t.text "education"
    t.text "skills"
    t.text "coding_languages"
    t.string "english_proficiency"
    t.string "skype_username"
    t.string "linkedin_profile_url"
    t.string "github_profile_url"
    t.integer "candidate_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["candidate_id"], name: "index_candidate_profiles_on_candidate_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.integer "status", default: 0
    t.string "cpf"
    t.string "address"
    t.string "phone"
    t.string "occupation"
    t.string "educational_level"
    t.string "birthday"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zip_code"
    t.index ["email"], name: "index_candidates_on_email", unique: true
    t.index ["reset_password_token"], name: "index_candidates_on_reset_password_token", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "url_domain"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
  end

  create_table "employees", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id"
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  end

  create_table "invites", force: :cascade do |t|
    t.integer "position_id", null: false
    t.integer "candidate_id", null: false
    t.integer "salary_from"
    t.integer "salary_to"
    t.string "message"
    t.integer "position_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["candidate_id"], name: "index_invites_on_candidate_id"
    t.index ["position_id"], name: "index_invites_on_position_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "title"
    t.string "industry"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id"
    t.index ["company_id"], name: "index_positions_on_company_id"
  end

  add_foreign_key "candidate_notes", "candidates"
  add_foreign_key "candidate_notes", "employees"
  add_foreign_key "candidate_profiles", "candidates"
  add_foreign_key "employees", "companies"
  add_foreign_key "invites", "candidates"
  add_foreign_key "invites", "positions"
  add_foreign_key "positions", "companies"
end
