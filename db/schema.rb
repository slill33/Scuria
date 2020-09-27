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

ActiveRecord::Schema.define(version: 2020_09_27_195325) do

  create_table "backlog_columns", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "position", default: 0, null: false, unsigned: true
    t.integer "backlog_id", default: 0, null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "color", limit: 8, default: "", null: false
  end

  create_table "backlog_item_comments", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.text "content", null: false
    t.integer "backlog_item_id", default: 0, null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "backlog_item_to_backlog_tags", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "backlog_item_id", default: 0, null: false, unsigned: true
    t.integer "backlog_tag_id", default: 0, null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "backlog_items", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "point", default: 0, null: false, unsigned: true
    t.integer "priority", unsigned: true
    t.integer "user_id", default: 0, null: false, unsigned: true
    t.integer "backlog_column_id", default: 0, null: false, unsigned: true
    t.integer "backlog_tag_id", default: 0, null: false, unsigned: true
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "parent_id", default: 0, null: false, unsigned: true
    t.integer "backlog_id", default: 0, null: false, unsigned: true
    t.text "description", null: false
  end

  create_table "backlog_tags", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "backlog_id", default: 0, null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "backlog_types", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "team_id", default: 0, null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "backlogs", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "team_id", default: 0, null: false, unsigned: true
    t.integer "parent_id", default: 0, null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "hashcode", default: "", null: false
    t.integer "backlog_type_id", default: 0, null: false, unsigned: true
  end

  create_table "teams", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "user_to_backlog_items", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id", default: 0, null: false, unsigned: true
    t.integer "backlog_item_id", default: 0, null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_to_backlogs", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id", default: 0, null: false, unsigned: true
    t.integer "backlog_id", default: 0, null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", null: false
    t.string "name"
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "team_id", null: false, unsigned: true
    t.boolean "super", default: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
