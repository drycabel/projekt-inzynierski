class AddOwnerIdToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :owner_id, :integer
  end
end
