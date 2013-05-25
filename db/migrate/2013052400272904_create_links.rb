class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :name
      t.string :url
      t.string :description
      t.boolean :published

      t.timestamps
    end

    create_table :linkmaincats do |t|
      t.string :name

      t.timestamps
    end

    create_table :linksubcats do |t|
      t.string :name

      t.timestamps
    end

    create_table :linkpagecats do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    # drop_table :links
    # drop_table :linkmaincats
    # drop_table :linksubcats
    # drop_table :linkpagecats
  end
end
