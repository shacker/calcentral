class CreateLinkmaincatsLinksJoinTable < ActiveRecord::Migration
  def self.up
    create_table :linkmaincats_links, :id => false do |t|
      t.integer :linkmaincat_id
      t.integer :link_id
    end

    add_index :linkmaincats_links, [:linkmaincat_id, :link_id]
  end

  def self.down
    drop_table :linkmaincats_links
  end
end
