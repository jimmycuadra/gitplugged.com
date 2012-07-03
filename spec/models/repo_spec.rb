require "spec_helper"

describe Repo do
  let(:repo) { FactoryGirl.build(:repo) }

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
    duplicate = FactoryGirl.build(:repo)
    duplicate.valid?
    duplicate.should have(1).error_on(:name)
  end

  it "has many votes" do
    repo.votes.should be_an(Array)
  end
end
