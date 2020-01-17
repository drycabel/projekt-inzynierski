class AddBirthDateToUsers < ActiveRecord::Migration[6.0]
  def up
    remove_column :users, :age
    add_column :users, :birth_date, :date
  end

  def down
    remove_column :users, :birth_date
    add_column :users, :age, :integer
  end
end
