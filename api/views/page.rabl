object @page

attributes :id, :slug_url, :body, :view_count, :updated_at, :created_at

# 下面2种方式效果等同
# node(:user) {|m| partial("account", :object => m.account) }
child :account => :user do
  extends "account"
end