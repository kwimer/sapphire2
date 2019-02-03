class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      # t.string :name
      # t.string :description
      t.string :headquarters
      t.string :origin_country

      t.jsonb :external_ids
      t.jsonb :external_ids, index: {using: :gin}
      t.timestamps
    end
  end
end
