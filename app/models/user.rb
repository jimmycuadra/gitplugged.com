class User < ActiveRecord::Base
  validates :twitter_uid, presence: true
  validates :name, presence: true
  has_many :votes

  def self.create_with_omniauth(auth)
    user             = new
    user.twitter_uid = auth["uid"]
    user.name        = auth["info"]["name"]
    user.save!
    user
  end

  attr_accessible :name, :twitter_uid

  def klout_score
    begin
      klout_id = Klout::Identity.find_by_twitter_id(twitter_uid)['id']
    rescue Klout::NotFound => e
      return 1.0
    end

    return Klout::User.new(klout_id).score['score']

  end

end
