class AddPolymorphicToTokens < ActiveRecord::Migration[6.0]
  def up
    rename_column :tokens, :user_id, :ownerable_id
    add_column :tokens, :ownerable_type, :string
  end

  def down
    rename_column :tokens, :ownerable_id, :user_id
    remove_column :tokens, :ownerable_type
  end
end
