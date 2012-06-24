class Repo < ActiveRecord::Base
  attr_accessible :name, :vote_sum, :week_start

  has_many :votes

  validates :name, presence: true, uniqueness: true
  validates :vote_sum, presence: true
  validates :week_start, presence: true
end
