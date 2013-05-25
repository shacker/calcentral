class AddLinksectionid < ActiveRecord::Migration
  def change
    add_column :links, :linksection_id, :integer
  end
end
