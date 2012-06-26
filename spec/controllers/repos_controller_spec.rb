require "spec_helper"

describe ReposController do
  describe "#index" do
    it "assigns @winners" do
      Repo.stub(recent_winners: "winners")
      get :index
      assigns(:winners).should == "winners"
    end

    it "assigns @repos" do
      Repo.stub(in_the_running: "repos")
      get :index
      assigns(:repos).should == "repos"
    end
  end

  describe "#create" do
    it "responds with a Repo if nomination is successful" do
      Repo.stub(:nominate)
      post :create, format: "json"
      response.code.should == "201"
    end

    it "responds with an error if the Repo was already nominated" do
      Repo.stub(:nominate) { raise Repo::AlreadyNominated }
      post :create, format: "json"
      response.code.should == "409"
    end

    it "responds with an error if the Repo doesn't exist" do
      Repo.stub(:nominate) { raise Repo::NotFound }
      post :create, format: "json"
      response.code.should == "422"
    end
  end
end
