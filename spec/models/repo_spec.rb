require "spec_helper"

describe Repo do
  let(:repo) { Repo.new(name: "foo/bar", vote_sum: 1.0, week_start: Date.today.beginning_of_week) }

  it "requires a name" do
    repo.name = nil
    repo.valid?
    repo.should have(1).error_on(:name)
  end

  it "requires a vote_sum" do
    repo.vote_sum = nil
    repo.valid?
    repo.should have(1).error_on(:vote_sum)
  end

  it "requires a week_start" do
    repo.week_start = nil
    repo.valid?
    repo.should have(1).error_on(:week_start)
  end

  it "has a unique name" do
    repo.save
    duplicate = Repo.create(name: "foo/bar", vote_sum: 2.0, week_start: 1.week.ago.beginning_of_week)
    duplicate.should have(1).error_on(:name)
  end

  it "has many votes" do
    repo.votes.should be_an(Array)
  end
end
