require "spec_helper"

describe Vote do
  let(:repo) { Repo.create(name: "rails/rails", vote_sum: 1.0, week_start: Date.today.beginning_of_week) }

  let(:user) do
    user = User.new
    user.name = "Joe Blow"
    user.twitter_uid = "abcdefg"
    user.save
    user
  end

  let(:vote) { Vote.new(repo: repo, user: user, value: 1.0) }

  it "requires a repo_id" do
    vote.repo_id = nil
    vote.valid?
    vote.should have(1).error_on(:repo_id)
  end

  it "allows a user only one vote per repo" do
    second_vote = vote.clone
    vote.save
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
