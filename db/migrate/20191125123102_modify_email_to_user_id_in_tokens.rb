class ModifyEmailToUserIdInTokens < ActiveRecord::Migration[6.0]
  def up
    remove_column :tokens, :email
    add_column :tokens, :user_id, :integer
  end

  def down
    remove_column :tokens, :user_id
    add_column :tokens, :email, :string
  end
end
