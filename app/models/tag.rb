class Tag < ActiveRecord::Base
  has_and_belongs_to_many :deals

  DELIMITER = '%'
  KINDS     = ['state', 'zip']
  STATES    = %w/AL AK AZ AR CA CO CT DE FL GA
                 HI ID IL IN IA KS KY LA ME MD
                 MA MI MN MS MO MT NE NV NH NJ
                 NM NY NC ND OH OK OR PA RI SC
                 SD TN TX UT VT VA WA WV WI DE/

  def self.find_or_create words
    words.map! {|w| (w =~ /([0-9]{5})(?:-[0-9]{4})?/) ? $~[1] : w.upcase }
    tags = Tag.where :content => words
    existing_words = tags.map &:content
    new_words = words - existing_words
    new_words.each do |w|
      if w.length == 2 && Tag::STATES.include?(w)
        tags << Tag.create(:content => w, :kind => 'state')
      elsif w =~ /[0-9]{5}/
        tags << Tag.create(:content => w, :kind => 'zip')
      else
        tags << Tag.create(:content => w)
      end
    end
    tags
  end
end
