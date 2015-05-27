class ChangeAttachments < ActiveRecord::Migration
  self.up do
    add_column :attachments, :data, :attachment
    add_column :attachments, :title, :string
    add_column :attachments, :original, :string
  end

  self.down do
    remove_column :attachments, :url
    remove_column :attachments, :title
    remove_column :attachments, :original
  end
end
