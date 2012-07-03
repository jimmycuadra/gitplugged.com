class Vote < ActiveRecord::Base
  attr_accessible :repo, :user, :value

  belongs_to :repo
  belongs_to :user

  after_create :add_value_to_repo

  validates :repo_id, presence: true, uniqueness: { scope: :user_id }
  validates :user_id, presence: true
  validates :value, presence: true

  def self.for_repo_by_user(repo_name, user)
    repo = Repo.find_by_name!(repo_name)

    repo.votes.build(user: user, value: user.score)
  end

  private

  def add_value_to_repo
    repo.update_attributes!(vote_sum: repo.vote_sum + value)
  end
end
