class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :slug_url, :limit => 50, :null => false
      t.text :body
      t.integer :view_count, :default => 0
      t.references :account, :null => false
      t.timestamps
    end

    add_index :blogs, :blog_content_id
  end

  def self.down
    drop_table :pages
  end
end
