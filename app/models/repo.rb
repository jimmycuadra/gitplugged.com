class Repo < ActiveRecord::Base
  attr_accessible :name, :vote_sum, :week_start
end