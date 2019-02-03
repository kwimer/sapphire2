class CreateSeasons < ActiveRecord::Migration[5.2]
  def change
    create_table :seasons, id: :uuid do |t|
      t.belongs_to :series, type: :uuid, index: true
      # t.string :title
      # t.string :summary
      t.integer :number
      t.date :start_date

      t.jsonb :external_ids, index: {using: :gin}
      t.jsonb :translations

      t.timestamps
    end
    add_index :seasons, [:series_id, :number], unique: true
  end
end