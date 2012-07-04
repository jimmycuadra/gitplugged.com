require "spec_helper"

describe SessionsController do
  let(:user) { FactoryGirl.create(:user) }

  describe "#create" do
    before do
      request.env["omniauth.auth"] = { "uid" => user.twitter_uid }

      get :create
    end

    it "logs the user in" do
      controller.send(:logged_in?).should be_true
    end

    it "redirects to the root with a notice" do
      response.should redirect_to(root_url)
      flash[:notice].should include("logged in")
    end
  end

  describe "#destroy" do
    before do
      session[:uid] = user.id

      get :destroy
    end

    it "logs the user out" do
      controller.send(:logged_in?).should_not be_true
    end

    it "redirects to the root with a notice" do
      response.should redirect_to(root_url)
      flash[:notice].should include("logged out")
    end
  end
end
