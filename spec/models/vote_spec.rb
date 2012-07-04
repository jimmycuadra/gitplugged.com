require "spec_helper"

describe Vote do
  let(:repo) { FactoryGirl.create(:repo) }

  let(:user) do
    user = FactoryGirl.create(:user)
    user.stub(score: 30.0)
    user
  end

  let(:vote) { FactoryGirl.build(:vote, repo: repo, user: user) }

  it "requires a repo_id" do
    vote.repo_id = nil
    vote.valid?
    vote.should have(1).error_on(:repo_id)
  end

  it "allows a user only one vote per repo" do
    vote.save
    second_vote = FactoryGirl.build(:vote, repo: repo, user: user)
    second_vote.valid?
    second_vote.should have(1).error_on(:repo_id)
  end

  it "requires a user_id" do
    vote.user_id = nil
    vote.valid?
    vote.should have(1).error_on(:user_id)
  end

  it "requires a value" do
    vote.value = nil
    vote.valid?
    vote.should have(1).error_on(:value)
  end
end
