require "spec_helper"

describe ReposController do
  describe "#index" do
    it "responds with the repos in the current week's contest" do
      Repo.should_receive(:in_the_running)
      get :index
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
