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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120623234113) do

  create_table "repos", :force => true do |t|
    t.string   "name"
    t.integer  "vote_sum"
    t.date     "week_start"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "repos", ["name"], :name => "index_repos_on_name"
  add_index "repos", ["week_start", "vote_sum"], :name => "index_repos_on_week_start_and_vote_sum"

  create_table "users", :force => true do |t|
    t.string   "twitter_uid"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "users", ["twitter_uid"], :name => "index_users_on_twitter_uid"

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "repo_id"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "votes", ["repo_id", "value"], :name => "index_votes_on_repo_id_and_value"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
