require "spec_helper"

describe WinnersController do
  describe "#index" do
    it "responds with the winning repos from the previous weeks" do
      Repo.should_receive(:recent_winners)
      get :index
    end
  end
end
