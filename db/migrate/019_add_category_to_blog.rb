# encoding: utf-8

# robbin把类别取消了，其实咱们还是需要的
class AddCategoryToBlog < ActiveRecord::Migration
  def self.up
    # 1.添加Category模型
    # category = {
    #   1 ： announcement, #通告
    #   2 ： manual,       #秘籍
    #   3 ： news,         #新闻
    #   4 ： tutorial,     #教程
    # }

    create_table :categories do |t|
      t.string :name, :limit => 26
      t.string :role, :default => 'any', :limit => 20 #限定角色
      t.boolean :is_menu, :default => false           #是否主菜单

      t.timestamps
    end

    [
        {:name => 'announcement'},
        {:name => 'manual'},
        {:name => 'news'},
        {:name => 'tutorial'},
        {:name => 'blackboard'}
    ].each do |c|
      Category.create c
    end

    # 2.blog_content_en_id 英文内容，如果还需要法文、日文等，可以对BlogContent模型进行处理
    change_table :blogs do |t|
      t.integer :category_id
      t.integer :blog_content_en_id
    end
  end

  def self.down
    change_table :blogs do |t|
      t.remove :category_id
      t.remove :blog_content_en_id
    end

    drop_table :categories
  end
end
