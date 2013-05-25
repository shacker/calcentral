class CreateLinksections < ActiveRecord::Migration
  def change
    create_table :linksections do |t|
      t.references :linkmaincat
      t.references :linksubcat
      t.references :linkpagecat

      t.timestamps
    end
    add_index :linksections, :linkmaincat_id
    add_index :linksections, :linksubcat_id
    add_index :linksections, :linkpagecat_id
  end
end
