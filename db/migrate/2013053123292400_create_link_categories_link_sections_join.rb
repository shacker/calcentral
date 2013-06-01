class CreateLinkCategoriesLinkSectionsJoin < ActiveRecord::Migration
  create_table :link_categories_link_sections, :id => false do |t|
      t.references :link_category
      t.references :link_section
  end

  def down
    drop_table :link_categories_link_sections
  end
end

