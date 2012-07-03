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
    duplicate = FactoryGirl.build(:repo, name: repo.name)
    duplicate.valid?
    duplicate.should have(1).error_on(:name)
  end

  it "has many votes" do
    repo.votes.should be_an(Array)
  end

  describe ".recent_winners" do
    it "returns the highest scoring repo per week for the last 3 weeks" do
      winner_one = FactoryGirl.create(:repo, week_start: 1.week.ago.beginning_of_week, vote_sum: 30.0)
      winner_two = FactoryGirl.create(:repo, week_start: 2.week.ago.beginning_of_week, vote_sum: 30.0)
      winner_three = FactoryGirl.create(:repo, week_start: 3.week.ago.beginning_of_week, vote_sum: 30.0)

      loser_two = FactoryGirl.create(:repo, week_start: 2.week.ago.beginning_of_week, vote_sum: 15.0)
      loser_three = FactoryGirl.create(:repo, week_start: 3.week.ago.beginning_of_week, vote_sum: 15.0)

      described_class.recent_winners.should == [winner_one, winner_two, winner_three]
    end

    it "returns an empty array if there are no recent winners" do
      described_class.recent_winners.should be_empty
    end
  end

  describe ".in_the_running" do
    let!(:current) do
      3.times.map { FactoryGirl.create(:repo, vote_sum: [1.0, 15.0, 30.0].sample) }
    end

    let!(:old) do
      2.times.map { FactoryGirl.create(:repo, week_start: 1.week.ago.beginning_of_week) }
    end

    it "returns the repos nominated this week" do
      described_class.in_the_running.sort.should == current.sort
    end

    it "sorts the repos with vote_sum descending" do
      vote_sums = described_class.in_the_running.map(&:vote_sum)
      vote_sums.should == vote_sums.sort.reverse
    end
  end
end
