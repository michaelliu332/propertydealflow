module DealHelper
  def tweet_path(deal)
    (deal.tweet_id.blank?) ? deal_path(deal) : "http://twitter.com/#{deal.user.nickname}/status/#{deal.tweet_id}"
  end
end
