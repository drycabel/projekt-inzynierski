class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.string :email
      t.integer :event_id
      t.integer :sender_id
      t.integer :recipient_id
      t.timestamps
    end
  end
end
