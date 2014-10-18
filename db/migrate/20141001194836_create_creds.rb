class CreateCreds < ActiveRecord::Migration
  def change
    create_table :creds do |t|
      t.integer :org_id
      t.integer :user_id
      t.string  :status, default: "admin"

      t.timestamps
    end
  end
end
