object @comment
attributes :id, :content, :blog_id, :account_id, :brief_content, :md_content, :created_at

node(:user) {|c| c.account.name }

child :blog do
  #extends "blog" 在blogs中扩展了comments，导致死循环
  attributes :id, :title, :slug_url
end