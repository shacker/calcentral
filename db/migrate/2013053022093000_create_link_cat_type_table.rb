class CreateLinkCatTypeTable < ActiveRecord::Migration
  def up
    create_table "link_cat_types", :force => true do |t|
      t.string   "name",  :null => false
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
  end

  def down
    drop_table :link_cat_types
  end
end
