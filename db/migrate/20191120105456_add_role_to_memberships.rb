class AddRoleToMemberships < ActiveRecord::Migration[6.0]
  def change
    add_column :memberships, :role, :integer, default: 10, null: false
  end
end
