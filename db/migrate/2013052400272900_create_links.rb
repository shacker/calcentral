class CreateLinks < ActiveRecord::Migration
  def change
    create_table :link do |t|
      t.string :name
      t.string :url
      t.string :description
      t.boolean :published

      t.timestamps
    end

    create_table :link_menucats do |t|
      t.string :name

      t.timestamps
    end

    create_table :link_submenucats do |t|
      t.string :name

      t.timestamps
    end

    create_table :link_pagecats do |t|
      t.string :name

      t.timestamps
    end
  end
end
