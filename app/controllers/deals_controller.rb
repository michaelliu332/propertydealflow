require 'twitter_search'
class DealsController < ApplicationController
  def index
	
    client = TwitterSearch::Client.new 
    search_terms = SearchTerm.find(:first)
    @deals = client.query(:q => search_terms.text, :q => search_terms.hashtag, :q => search_terms.name, :rpp => 10)
     #render :text=> @deals.inspect and return
        #@deals = Deal.all
end



  
  def scrolldata
    client = TwitterSearch::Client.new 
    search_terms = SearchTerm.find(:first)
    @deals = client.query(:q => search_terms.text, :q => search_terms.hashtag, :q => search_terms.name, :rpp => params[:page].to_i*10 )
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
    render :index
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


