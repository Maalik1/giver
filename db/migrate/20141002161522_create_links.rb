class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :org_id
      t.string  :location
      t.string  :name
      t.string  :brand

      t.timestamps
    end
  end
end
