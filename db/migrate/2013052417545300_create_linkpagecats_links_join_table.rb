class CreateLinkpagecatsLinksJoinTable < ActiveRecord::Migration
  def self.up
    create_table :linkpagecats_links, :id => false do |t|
      t.integer :linkpagecat_id
      t.integer :link_id
    end

    add_index :linkpagecats_links, [:linkpagecat_id, :link_id]
  end

  def self.down
    # drop_table :linkpagecats_links
  end
end
