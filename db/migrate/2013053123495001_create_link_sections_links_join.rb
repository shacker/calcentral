class CreateLinkSectionsLinksJoin < ActiveRecord::Migration
  create_table :link_sections_links, :id => false do |t|
      t.references :link_section
      t.references :link
  end

  def down
    drop_table :link_sections_links
  end
end
