class CreateMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :memberships do |t|
      t.belongs_to :user
      t.belongs_to :event
      t.datetime :join_date
      t.timestamps 
    end
  end
end
