class Vote < ActiveRecord::Base
  attr_accessible :repo_id, :repo, :user_id, :user, :value
  belongs_to :repo
  belongs_to :user

  validates_presence_of :repo_id,:user_id,:value
  validates_uniqueness_of :repo_id, :scope =>[:user_id]
end
