# encoding: utf-8

# 暂时用数组代替类别，如果以后类别持续增加，可以添加Category模型
# category = {
#   1 ： announcement, #通告
#   2 ： manual,       #秘籍
#   3 ： news,         #新闻
#   4 ： tutorial,     #教程
# }
class Category < ActiveRecord::Base
  has_many :blogs

  validates :name, :presence => true

  scope :menus, where(:is_menu => true)

  def self.blogs_of(category)
    self.find_by_name(category).blogs.order('id DESC')
  end
end
