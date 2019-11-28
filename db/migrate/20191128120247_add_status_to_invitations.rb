class AddStatusToInvitations < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :status, :integer, default: 10
  end
end
