class Repo < ActiveRecord::Base
  class AlreadyNominated < StandardError; end
  class NotFound < StandardError; end

  attr_accessible :name, :vote_sum, :week_start

  has_many :votes

  validates :name, presence: true, uniqueness: true
  validates :vote_sum, presence: true
  validates :week_start, presence: true

  def self.recent_winners
    3.times.map do |i|
      offset = i + 1
      query = where(week_start: offset.weeks.ago.beginning_of_week).order("vote_sum DESC").limit(1)
      query.first
    end.compact
  end

  def self.in_the_running
    where(week_start: Date.today.beginning_of_week).order("vote_sum DESC")
  end

  def self.nominate(repo_attributes, user)
    raise AlreadyNominated if Repo.find_by_name(repo_attributes[:name]).exist?

    begin
      Octokit.repo(params[:repo][:name])
    rescue Octokit::NotFound
      raise NotFound
    end

    score = user.klout_score

    repo = create!(
      name: repo_attributes[:name],
      week_start: Date.today.beginning_of_week,
      vote_sum: klout_score,
    )

    Vote.create!(repo: repo, user: current_user, value: score)

    repo
  end
end
