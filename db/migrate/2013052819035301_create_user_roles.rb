class CreateUserRoles < ActiveRecord::Migration
  def up
    create_table :user_roles do |t|
      t.string :name
      t.string :slug
    end
  end

  def down
    drop_table :user_roles
  end
end
