class CreateLinksubcatsLinksJoinTable < ActiveRecord::Migration
  def self.up
    create_table :linksubcats_links, :id => false do |t|
      t.integer :linksubcat_id
      t.integer :link_id
    end

    add_index :linksubcats_links, [:linksubcat_id, :link_id]
  end

  def self.down
    drop_table :linksubcats_links
  end
end
