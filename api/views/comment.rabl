object @comment
attributes :id, :brief_content

node(:user) {|c| c.account.name }

child :blog do
  extends "blog"
end