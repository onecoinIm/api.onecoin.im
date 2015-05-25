object @blog

attributes :id, :title, :slug_url, :view_count, :commentable, :has_i18n, :comments_count,
           :cached_tags, :content_updated_at, :created_at

node(:category) { |m| m.category.name }

child :blog_content => :body do |b|
  attributes :content
end

child :blog_content_en => :body_en do |b|
  attributes :content
end

# 下面2种方式效果等同
# node(:user) {|m| partial("account", :object => m.account) }
child :account => :user do
  extends "account"
end

node :comments  do |b|
  b.comments.map do |c|
    c.id
  end
end

