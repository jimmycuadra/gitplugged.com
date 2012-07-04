require "spec_helper"

describe Repo do
  let(:repo) { FactoryGirl.build(:repo) }
  let(:user) { FactoryGirl.create(:user) }

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

  describe ".nominate" do
    it "raises if the repo has already been nominated" do
      Repo.stub_chain(:where, exists?: true)

      expect { Repo.nominate({ name: "foo/bar" }, user) }.to raise_error(Repo::AlreadyNominated)
    end

    it "raises if the repo doesn't exist on GitHub" do
      Octokit.stub(:repo) { raise Octokit::NotFound }

      expect { Repo.nominate({ name: "foo/bar" }, user) }.to raise_error(Repo::NotFound)
    end

    context "when successful" do
      before { Octokit.stub(repo: true) }

      subject { Repo.nominate({ name: "foo/bar" }, user) }

      it { should_not be_a_new_record }

      its(:vote_sum) { should == user.score }

      it "creates a new vote for the repo with the user's score" do
        votes = subject.votes.select { |v| v.user == user }

        votes.size.should == 1
        votes.first.value.should == user.score
      end
    end
  end
end
