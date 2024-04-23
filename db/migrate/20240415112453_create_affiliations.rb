class CreateAffiliations < ActiveRecord::Migration[7.0]
  def change
    create_table :affiliations, id: :uuid do |t|
      t.references :person, type: :uuid, references: :people, index: true, foreign_key: {to_table: :people} 
      t.string :affiliation_name

      t.timestamps
    end
  end
end
