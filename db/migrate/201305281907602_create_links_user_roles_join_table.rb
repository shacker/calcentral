class CreateLinksUserRolesJoinTable < ActiveRecord::Migration
  create_table :links_user_roles, :id => false do |t|
      t.references :link
      t.references :user_role
  end

  def down
    drop_table :links_user_roles
  end
end
