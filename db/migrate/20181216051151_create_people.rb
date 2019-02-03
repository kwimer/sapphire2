class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name
      t.string :aka, array: true
      t.integer :gender
      t.date :birth_date
      t.string :birth_location
      t.date :death_date
      t.string :role
      t.string :url
      t.boolean :adult

      t.text :biography

      t.jsonb :external_ids, index: {using: :gin}

      t.timestamps
    end

  end
end
