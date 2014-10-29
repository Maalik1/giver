class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :org_id
      t.string  :slug
      t.string  :title
      t.string  :photo
      t.string  :video
      t.string  :blurb
      t.text    :story
      t.text    :challenges
      t.string  :location
      t.float   :latitude
      t.float   :longitude
      t.date    :starts
      t.date    :ends
      t.decimal :goal
      t.integer :updates_count,   default: 0, null: false
      t.integer :donations_count, default: 0, null: false
      t.integer :comments_count,  default: 0, null: false
      t.boolean :active,          default: true

      t.timestamps
    end

    add_index :projects, :slug, unique: true
    
  end
end
