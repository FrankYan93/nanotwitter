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

  create_table "followerfollowings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "followed_user_id"
    t.date    "follow_date"
  end

  create_table "hashtags", force: :cascade do |t|
    t.string "content"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "tweet_id"
  end

  create_table "mentions", force: :cascade do |t|
    t.integer "tweet_id"
    t.integer "user_mentioned_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id"
    t.string  "content"
    t.string  "type"
    t.integer "like_id"
    t.integer "follower_id"
    t.integer "reply_id"
    t.boolean "read_mark"
    t.date    "create_time"
  end

  create_table "replies", force: :cascade do |t|
    t.integer "user_id"
    t.integer "tweet_id"
    t.integer "reply_id"
    t.string  "content"
  end

  create_table "tweethashtags", force: :cascade do |t|
    t.integer "tweet_id"
    t.integer "hashtag_id"
  end

  create_table "tweets", force: :cascade do |t|
    t.string  "content"
    t.date    "create_time"
    t.integer "user_id"
    t.boolean "is_forwarding"
    t.integer "forward_id"
    t.boolean "is_mentioning"
    t.boolean "has_hashtag"
    t.integer "like_numbers"
    t.integer "forwarded_number"
    t.integer "reply_number"
  end

  create_table "users", force: :cascade do |t|
    t.string  "username"
    t.string  "password"
    t.date    "birthday"
    t.string  "nickname"
    t.string  "description"
    t.integer "follower_number"
    t.integer "followering_number"
  end

end
