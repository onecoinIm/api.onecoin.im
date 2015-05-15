class AddTokenToAccount < ActiveRecord::Migration
  change_table :accounts do |t|
    t.string :token
  end
end
