class SetDefaultLinkpubVal < ActiveRecord::Migration
  def change
    change_column :links, :published, :boolean, :default => true
  end
end
