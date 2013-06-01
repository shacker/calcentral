class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :name
      t.string :url
      t.string :description
      t.boolean :published, :default => true

      t.timestamps
    end

    create_table :link_sections do |t|
      t.integer :link_main_cat_id
      t.integer :link_sub_cat_id
      t.integer :link_page_cat_id

      t.timestamps
    end

    create_table :link_categories, :force => true do |t|
      t.string   "name",  :null => false
      t.string   "slug",  :null => false
      t.boolean :top_level, :default => false

      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

  end

  def self.down
    drop_table :links
    drop_table :link_sections
    drop_table :link_categories
  end
end
