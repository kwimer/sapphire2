class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name
      t.string :slug, uniq: true
      t.string :aka, array: true
      t.integer :gender
      t.date :birth_date
      t.string :birth_location
      t.date :death_date
      t.string :role

      t.text :biography

      t.jsonb :extra_fields
      t.jsonb :external_ids, index: {using: :gin}

      t.timestamps
    end

  end
end
