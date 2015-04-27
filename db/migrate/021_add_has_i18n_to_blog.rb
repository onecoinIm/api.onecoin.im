class AddHasI18nToBlog < ActiveRecord::Migration
  def self.up
    add_column :blogs, :has_i18n, :boolean
  end

  def self.down
    remove_column :blogs, :has_i18n
  end
end
