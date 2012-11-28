class Repo < ActiveRecord::Base
  class AlreadyNominated < StandardError; end
  class NotFound < StandardError; end

  attr_accessible :name, :vote_sum, :week_start

  has_many :votes

  validates :name, presence: true, uniqueness: true
  validates :vote_sum, presence: true
  validates :week_start, presence: true

  class << self
    def recent_winners
      3.times.map { |i| winner_for_past_week(i + 1).first }.compact
    end

    def in_the_running
      where(week_start: Date.today.beginning_of_week).order("vote_sum DESC")
    end

    def nominate(repo_attributes, user)
      ensure_not_already_nominated(repo_attributes[:name])
      ensure_exists_on_github(repo_attributes[:name])

      score = user.score

      repo = create!(
        name: repo_attributes[:name],
        week_start: Date.today.beginning_of_week,
        vote_sum: 0.0,
      )

      Vote.create!(repo: repo, user: user, value: score)

      repo
    end

    private

    def winner_for_past_week(offset = 1)
      where(week_start: offset.weeks.ago.beginning_of_week).order("vote_sum DESC").limit(1)
    end

    def ensure_not_already_nominated(name)
      raise AlreadyNominated if where(name: name).exists?
    end

    def ensure_exists_on_github(name)
      Octokit.repo(name)
    rescue Octokit::NotFound
      raise NotFound
    end
  end
end
