class User < ActiveRecord::Base
  validates :twitter_uid, presence: true
  validates :name, presence: true

  def self.create_with_omniauth(auth)
    user = new
    user.twitter_uid = auth["uid"]
    user.name = auth["info"]["name"]
    user.save!
    user
  end
end
