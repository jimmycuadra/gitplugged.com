require "spec_helper"

describe User do
  let(:user) do
    user = User.new
    user.twitter_uid = "abcdefg"
    user.name = "Joe Blow"
    user
  end

  it "requires a twitter_uid" do
    user.twitter_uid = nil
    user.valid?
    user.should have(1).error_on(:twitter_uid)
  end

  it "requires a name" do
    user.name = nil
    user.valid?
    user.should have(1).error_on(:name)
  end

  it "has many votes" do
    user.votes.should be_an(Array)
  end

  describe ".create_with_omniauth" do
    let(:auth) do
      {
        "provider" => "twitter",
        "uid" => "abcdefg",
        "info" => {
          "name" => "Joe Blow",
        },
      }
    end

    let(:bad_auth) do
      { "info" => {} }
    end

    it "creates a new user given an OmniAuth hash" do
      User.create_with_omniauth(auth)
      user = User.find_by_twitter_uid(auth["uid"])
      user.name.should == "Joe Blow"
    end

    it "raises an exception if required credentials are not provided" do
      expect do
        User.create_with_omniauth(bad_auth)
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "#klout_score" do
    it "returns the Klout score if the user is connected to Klout via Twitter" do
      klout_user = mock("Klout::User", score: { "score" => 1.23 })
      Klout::Identity.stub(find_by_twitter_id: { "id" => "abcdefg" })
      Klout::User.stub(new: klout_user)

      user.klout_score.should == 1.23
    end

    it "returns 1.0 if the user is not connected to Klout via Twitter" do
      Klout::Identity.stub(:find_by_twitter_id) { raise Klout::NotFound }

      user.klout_score.should == 1.0
    end
  end
end
