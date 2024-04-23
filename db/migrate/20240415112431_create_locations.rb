class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations, id: :uuid do |t|
      t.references :person, type: :uuid, null: false, foreign_key: true 
      t.string :location_name

      t.timestamps
    end
  end
end
