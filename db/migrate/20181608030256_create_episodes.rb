class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.belongs_to :series, index: true
      t.belongs_to :season, index: true
      t.string :slug
      t.date :release_date
      t.integer :season_number
      t.integer :number
      t.jsonb :translations
      # t.string :title
      # t.string :summary
      # t.string :tagline
      t.jsonb :extra_fields
      # t.string :original_title
      # t.string :original_language
      # t.integer :season_number
      # t.integer :production_code
      t.jsonb :external_ids, index: {using: :gin}
      t.jsonb :external_scores, index: {using: :gin}
      t.timestamps
    end
    add_index :episodes, [:series_id, :season_id, :number], unique: true
    add_index :episodes, [:slug, :series_id], unique: true
  end
end
