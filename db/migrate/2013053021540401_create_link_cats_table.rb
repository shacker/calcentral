class CreateLinkCatsTable < ActiveRecord::Migration
  def up
    create_table "link_cats", :force => true do |t|
      t.string   "name",  :null => false
      t.string   "slug",  :null => false
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
      t.integer "link_cat_type_id", :null => false
    end
  end

  def down
    drop_table :link_cats
  end
end
