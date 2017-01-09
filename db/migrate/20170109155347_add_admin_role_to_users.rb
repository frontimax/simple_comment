class AddAdminRoleToUsers < ActiveRecord::Migration[5.0]
  def change
    # note todo: this is for time running out, i try to implement cancancan later! quick dirty way:
    add_column :users, :admin_role, :boolean, :default => false
  end
end
