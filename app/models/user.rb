class User < ActiveRecord::Base
  has_many :votes

  validates :twitter_uid, presence: true
  validates :name, presence: true

  def self.create_with_omniauth(auth)
    user             = new
    user.twitter_uid = auth["uid"]
    user.name        = auth["info"]["name"]
    user.save!
    user
  end

  def score
    begin
      klout_id = Klout::Identity.find_by_twitter_id(twitter_uid)["id"]
      Klout::User.new(klout_id).score["score"]
    rescue Klout::NotFound => e
      1.0
    end
  end
end
