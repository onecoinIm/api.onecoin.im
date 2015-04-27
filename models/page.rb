class Page < ActiveRecord::Base
  acts_as_cached(:version => 1, :expires_in => 1.week)
  attr_protected :account_id

  after_save :clean_cache
  before_destroy :clean_cache

  belongs_to :account

  validates :slug_url, :presence => true
  validates :slug_url, :length => {:in => 3..50}

  def clean_cache
    APP_CACHE.delete("#{CACHE_PREFIX}/rss/all")               # clean rss cache
    APP_CACHE.delete("#{CACHE_PREFIX}/layout/right")          # clean layout right column cache in _right.erb
  end

  def self.find_by_url(url)
    self.where(:slug_url => url).first
  end
end
