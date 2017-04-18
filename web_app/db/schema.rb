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

ActiveRecord::Schema.define(version: 20170418161630) do

  create_table "applicants", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.integer  "year"
    t.string   "email"
    t.boolean  "available"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "schedule_id"
    t.         "appid"
    t.integer  "mondayStartFirst",     default: 0
    t.integer  "mondayEndFirst",       default: 0
    t.integer  "tuesdayStartFirst",    default: 0
    t.integer  "tuesdayEndFirst",      default: 0
    t.integer  "wednesdayStartFirst",  default: 0
    t.integer  "wednesdayEndFirst",    default: 0
    t.integer  "thursdayStartFirst",   default: 0
    t.integer  "thursdayEndFirst",     default: 0
    t.integer  "fridayStartFirst",     default: 0
    t.integer  "fridayEndFirst",       default: 0
    t.integer  "mondayStartSecond",    default: 0
    t.integer  "mondayEndSecond",      default: 0
    t.integer  "tuesdayStartSecond",   default: 0
    t.integer  "tuesdayEndSecond",     default: 0
    t.integer  "wednesdayStartSecond", default: 0
    t.integer  "wednesdayEndSecond",   default: 0
    t.integer  "thursdayStartSecond",  default: 0
    t.integer  "thursdayEndSecond",    default: 0
    t.integer  "fridayStartSecond",    default: 0
    t.integer  "fridayEndSecond",      default: 0
    t.string   "semester"
    t.string   "classOne"
    t.string   "classTwo"
    t.string   "classThree"
    t.integer  "references"
    t.index ["schedule_id"], name: "index_applicants_on_schedule_id"
  end

  create_table "courses", force: :cascade do |t|
    t.integer  "courseNumber"
    t.integer  "mondayStart"
    t.integer  "mondayEnd"
    t.integer  "tuesdayStart"
    t.integer  "tuesdayEnd"
    t.integer  "wednesdayStart"
    t.integer  "wednesdayEnd"
    t.integer  "thursdayStart"
    t.integer  "thursdayEnd"
    t.integer  "fridayStart"
    t.integer  "fridayEnd"
    t.string   "professor"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "sectionNumber"
    t.string   "graderOne"
    t.string   "graderTwo"
    t.string   "graderThree"
    t.string   "graderFour"
  end

  create_table "recommendations", force: :cascade do |t|
    t.string   "professor"
    t.string   "pemail"
    t.string   "student"
    t.string   "semail"
    t.string   "course"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.decimal  "mondayStart"
    t.decimal  "mondayEnd"
    t.decimal  "tuesdayStart"
    t.decimal  "tuesdayEnd"
    t.decimal  "wednesdayStart"
    t.decimal  "wednesdayEnd"
    t.decimal  "thursdayStart"
    t.decimal  "thursdayEnd"
    t.decimal  "fridayStart"
    t.decimal  "fridayEnd"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.         "scheduleid"
    t.integer  "Applicantid"
    t.string   "schedulename"
    t.integer  "student_id"
    t.index ["student_id"], name: "index_schedules_on_student_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string   "title"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "fname"
    t.boolean  "admin",                  default: false
    t.integer  "role"
    t.boolean  "student"
    t.string   "lname"
    t.boolean  "professor",              default: false
    t.boolean  "stud"
    t.boolean  "admin_role",             default: false
    t.boolean  "student_role",           default: false
    t.boolean  "professor_role",         default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
