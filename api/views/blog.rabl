object @blog

attributes :id, :title, :slug_url, :view_count, :commentable,:has_i18n, :created_at, :comments_count,
           :content_updated_at, :cached_tags

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