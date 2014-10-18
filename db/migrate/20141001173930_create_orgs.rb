class CreateOrgs < ActiveRecord::Migration
  def change
    create_table :orgs do |t|
      t.string  :name
      t.string  :display_name
      t.string  :slug
      t.string  :ein
      t.string  :photo
      t.text    :description
      t.text    :mission
      t.string  :location
      t.float   :latitude
      t.float   :longitude
      t.boolean :tax_exempt, default: false

      t.timestamps
    end

    add_index :orgs, :slug, unique: true

  end
end
