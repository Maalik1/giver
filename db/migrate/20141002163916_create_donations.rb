class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :reward_id
      t.string  :uuid
      t.decimal :amount 
      t.boolean :anonymous, default: false

      t.timestamps
    end

    add_index :donations, :uuid, unique: true
    
  end
end