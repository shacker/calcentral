class CreateLinksLinksubcatsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :links_linksubcats, :id => false do |t|
      t.integer :linksubcat_id
      t.integer :link_id
    end

    add_index :links_linksubcats, [:linksubcat_id, :link_id]
  end

  def self.down
    # drop_table :links_linksubcats
  end
end
