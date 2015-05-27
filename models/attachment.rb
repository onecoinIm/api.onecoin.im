class Attachment < ActiveRecord::Base
  mount_uploader :file, FileUploader
  # validates_presence_of :file :title,

  attr_accessible :data

  belongs_to :account
  belongs_to :blog
  scope :orphan, where(:blog_id => nil)
end
