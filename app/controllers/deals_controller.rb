require 'twitter_search'
class DealsController < ApplicationController
  def index
    client = TwitterSearch::Client.new 
    search_terms = SearchTerm.find(:first)
     query = ""
    if !search_terms.text.blank?
       query = search_terms.text+" "
    end
   
    if !search_terms.hashtag.blank?
        data = search_terms.hashtag.split(",")
        if !data.blank?
           data.each do |data_hash|
           query = query+data_hash+ " OR "
           end
	   query = query.chomp(" OR ") if !query.blank? 
        end
end
    if !query.blank?
    @deals = client.query(:q => query, :rpp => 10)
        render :index
    else
     @deals = Deal.all
      render :filter_search
    end
end

  def scrolldata
    client = TwitterSearch::Client.new 
    search_terms = SearchTerm.find(:first)
    
    query = ""
    if !search_terms.text.blank?
       query = search_terms.text+" "
    end
   
    if !search_terms.hashtag.blank?
        data = search_terms.hashtag.split(",")
        if !data.blank?
           data.each do |data_hash|
           query = query+data_hash+ " OR "
           end
	   query = query.chomp(" OR ") if !query.blank? 
        end
end

   if !query.blank?
    @deals = client.query(:q => query, :page => params[:page].to_i, :rpp => 10)
		    if !@deals.blank? && @deals.size >= 10
			    
		       else
			@deals = []    
		     end
	    else
		    @deals = []  
	    end
    render :layout => false 
  end

  
  def show
    @deal = Deal.find_by_id(params[:id])
  end

  def filter
    unless params[:tags].blank?
      @deals = Deal.by_tags params[:tags]
    else
      @deals = Deal.all
    end
    render :filter_search
  end
  
  def search
    if params[:text]=~ /(\A|\s)%\S+/
      @deals = tweet_search(params[:text])
    render :tweet_search
    else
      @deals = Deal.where("content like ?", "%#{params[:text]}%")
    render :index
    end
  end

  def tweet_search(search_parameter)
    client = TwitterSearch::Client.new 
    tweets = client.query(search_parameter)
    return tweets
end


  def create
    content = params[:deal][:content]
    unless content.blank? || !current_user.active?
      @deal = Deal.create :content => content, :user => current_user
      current_user.twitter.update(content) rescue nil
    end
    redirect_to deals_path
  end
end


