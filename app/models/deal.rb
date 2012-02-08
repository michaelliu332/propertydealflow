class Deal < ActiveRecord::Base
  has_and_belongs_to_many :tags
  belongs_to :user

  default_scope order 'deals.id DESC'
  scope :by_tags, lambda {|tags| joins(:tags).where('tags.id' => tags).group('deals.id').having(['count(tags.id) = ?', tags.count])}
  attr_accessor :skip_url_shortening
  
  def skip_url_shortening?
    !!skip_url_shortening
  end

  def content_tags
    content.split.select {|w| w[0].chr == Tag::DELIMITER}.each {|w| w.slice!(0)}
  end

  before_create :shorten_urls, :unless => "skip_url_shortening?"
  after_save :associate_tags

  def associate_tags
    self.tags = Tag.find_or_create content_tags
  end

  def shorten_urls
    bitly = Bitly.new('presskey','R_dcd1c11a859d258df81f76fced09c6dc')
    self.content.gsub!(/(https?:\/\/)[^\s<]+/) {|url| bitly.shorten(url).short_url}
  end
end
