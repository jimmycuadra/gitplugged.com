class Vote < ActiveRecord::Base
  attr_accessible :repo, :user, :value

  belongs_to :repo
  belongs_to :user

  validates :repo, presence: true, uniqueness: { scope: :user_id }
  validates :user, presence: true
  validates :value, presence: true
end
