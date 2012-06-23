class Votes < ActiveRecord::Base
  attr_accessible :repo_id, :user_id, :value
end
