object @comment => :comment
attributes :id, :blog_id, :account_id, :brief_content, :md_content, :created_at

node(:user) {|c| c.account.name }
node(:body) {|c| c.content }
