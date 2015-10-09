# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151009053819) do

  create_table "applications", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "course_option_id"
    t.datetime "start_date"
    t.datetime "payment_due_date"
    t.datetime "payment_date"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "course_options", force: :cascade do |t|
    t.integer  "institution_id"
    t.integer  "course_id"
    t.string   "more_information"
    t.integer  "cost"
    t.integer  "duration"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "material_fee"
    t.datetime "intake_date"
    t.integer  "capacity"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
  end

  create_table "institutions", force: :cascade do |t|
    t.string   "name"
    t.string   "website"
    t.integer  "enrolment_fee"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.datetime "date_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
