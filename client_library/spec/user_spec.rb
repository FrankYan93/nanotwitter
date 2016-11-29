
require_relative '../client.rb'
require 'date'



describe "user" do

  before(:all) do
    User.base_uri = "http://0.0.0.0:4567"
    User.delete_by_name("test4")
    User.delete_by_name("test5")
    User.delete_by_name("test6")
    User.delete_by_name("test7")
    @user5 = User.create("test5","a")
    @user6 = User.create("test6","b")
    @user7 = User.create("test7","c")
    @testuser = User.find_by_name("testuser")
    follow = User.to_follow(@user5["id"],@user6["id"])
  end

  it "should create a user" do
    user = User.create("test4","ppp")
    expect(user["username"]).to eql("test4")
  end

  it "should delete a user" do
    user = User.delete_by_name("test4")
    expect(user["username"]).to eql("test4")
  #  User.find_by_id(user["id"]).should be_nil
  end

  it "should get a user" do
    user = User.find_by_id(@testuser["id"])
    expect(user["username"]).to eql("testuser")
  end

  it "should update a user" do
    attributes = {
      :user_id => @testuser["id"],
      :birthday => Date.parse("10/10/2010"),
      :description => "I am created for test :D"
    }
    user = User.UpdateProfile(@testuser["id"], attributes)
    expect(user["birthday"]).to eql("2010-10-10")
    expect(user["description"]).to  eql("I am created for test :D")
  end

  it "should get followers of a user" do
    users = User.followers(@user6["id"])
    expect(users[0]["username"]).to eql("test5")
  end

  it "should get followings of a user" do
    users = User.followings(@user5["id"])
    expect(users[0]["username"]).to eql("test6")
  end

  it "should let A follow B" do
    follow = User.to_follow(@user7["id"],@testuser["id"])
    expect(follow["user_id"]).to eql(@user7["id"])
  end

end
