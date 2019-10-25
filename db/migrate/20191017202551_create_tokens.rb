class CreateTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.string :email
      t.string :value, index: true
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
