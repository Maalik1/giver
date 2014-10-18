class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :project_id
      t.string  :uuid
      t.text    :body

      t.timestamps
    end

    add_index :messages, :uuid, unique: true

  end
end
