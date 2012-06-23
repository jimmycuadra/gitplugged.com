require "spec_helper"

describe User do
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
end
