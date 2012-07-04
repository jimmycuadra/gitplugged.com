require "spec_helper"

describe VotesController do
  let(:repo) { FactoryGirl.create(:repo) }
  let(:user) { FactoryGirl.create(:user) }

  describe "#create" do
    it "responds with the Repo if the vote is successful" do
      controller.stub(current_user: user)

      post :create, format: "json", repo_id: repo.id, vote: { repo_name: repo.name }

      response.code.should == "201"
    end

    it "responds with unauthorized if the user is not logged in" do
      post :create, format: "json", repo_id: repo.id, vote: { repo_name: repo.name }

      response.code.should == "401"
    end
  end
end
