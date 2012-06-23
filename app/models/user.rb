class User < ActiveRecord::Base
  attr_accessible :name, :twitter_uid
end
