class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string     :location
      t.string     :name
      t.string     :brand
      t.references :linkable, polymorphic: true

      t.timestamps
    end
  end
end
