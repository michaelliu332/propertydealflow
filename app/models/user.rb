class User < ActiveRecord::Base
  
  scope :active, where(:active => TRUE)
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.uid    = auth["uid"]
      user.name   = auth["user_info"]["name"]
    end
  end

  def twitter
     unless @twitter_user
       @twitter_user = Twitter::Client.new(:oauth_token => token, :oauth_token_secret => secret) rescue nil
     end
     @twitter_user
  end
end
