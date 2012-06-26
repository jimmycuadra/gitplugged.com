require "spec_helper"

describe ApplicationController do
  describe "#logged_in?" do
    it "is true if the user is logged in" do
      session[:user_id] = 1
      controller.should be_logged_in
    end

    it "is false if the user is not logged in" do
      controller.should_not be_logged_in
    end
  end

  describe "#current_user" do
    it "is nil if the user is not logged in" do
      controller.send(:current_user).should be_nil
    end

    it "is a User if the user is logged in" do
      user = mock
      User.stub(find: user)
      session[:user_id] = 1
      controller.send(:current_user).should == user
    end
  end
end
