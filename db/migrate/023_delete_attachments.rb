# 不把附件保存到数据库
class DeleteAttachments < ActiveRecord::Migration
  def self.up
    drop_table :attachments
  end

  def self.down
    # 便于迁移
    create_table :attachments do |t|
      t.string :file
      t.integer :account_id
      t.integer :blog_id
      t.datetime :created_at
    end
  end
end
