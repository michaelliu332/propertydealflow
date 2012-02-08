class Puller

  def self.run
    Lockfile("#{Rails.root}/tmp/puller", :retries => 0) do
      run_locked
    end
  end
  
  def self.run_locked
    since_id = Value.find_by_key('since_id').try(:value)
    users = User.active.map(&:nickname).compact
    search = Twitter::Search.new.from(users.join(' OR ')).since_id(since_id.to_i)
    tweets = search.fetch
    since_id = process_tweets tweets, since_id
    next_tweets = search.fetch_next_page
    while (next_tweets) 
      since_id = process_tweets next_tweets, since_id
      next_tweets = search.fetch_next_page
    end
    Value.find_or_create_by_key('since_id').update_attribute :value, since_id
  end
  
  def self.process_tweets tweets, since_id
    tweets.each do |t|
      since_id = t.id if t.id.to_i > since_id.to_i
      next if t.source =~ /Property Deal Flow/
      if t.text =~ /(\A|\s)%\S+/
        user = User.find_by_nickname t.from_user
        Deal.create :content => t.text, :user => user, :tweet_id => t.id_str, :skip_url_shortening => true
      end
    end
    
    since_id
  end
end