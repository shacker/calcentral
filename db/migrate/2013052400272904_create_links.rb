class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :name
      t.string :url
      t.string :description
      t.boolean :published

      t.timestamps
    end

    create_table "linkmaincats", :force => true do |t|
      t.string   "name",  :null => false
      t.string   "slug",  :null => false
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "linkpagecats", :force => true do |t|
      t.string   "name",  :null => false
      t.string   "slug",  :null => false
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "linksubcats", :force => true do |t|
      t.string   "name",  :null => false
      t.string   "slug",  :null => false
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

  end

  def self.down
    # drop_table :links
  end
end
