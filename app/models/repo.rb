class Repo < ActiveRecord::Base
  attr_accessible :name, :vote_sum, :week_start
  has_many :votes

  validates_presence_of :name,:vote_sum,:week_start
  validates_uniqueness_of :name
end
