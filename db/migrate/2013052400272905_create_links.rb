class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :name
      t.string :url
      t.string :description
      t.boolean :published, :default => true

      t.timestamps
    end

    create_table :linksections do |t|
      t.references :linkmaincat
      t.references :linksubcat
      t.references :linkpagecat

      t.timestamps
    end
    add_index :linksections, :linkmaincat_id
    add_index :linksections, :linksubcat_id
    add_index :linksections, :linkpagecat_id

    create_table :links_linksections, :id => false do |t|
      t.references :link
      t.references :linksection
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
    drop_table :links
    drop_table :linksections
    drop_table :links_linksections
  end
end
