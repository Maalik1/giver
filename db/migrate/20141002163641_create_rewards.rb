class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.integer :project_id
      t.string  :uuid
      t.decimal :amount
      t.text    :description
      t.boolean :shipping,       default: true
      t.date    :delivery_date
      t.boolean :limit,          default: false
      t.integer :limit_number

      t.timestamps
    end
  end
end
