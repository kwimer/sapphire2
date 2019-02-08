class CreateMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :media do |t|
      t.string :type
      t.boolean :active, null: false, default: false
      t.string :slug
      t.date :release_date
      t.string :status
      t.tsvector :tsv_title, index: {using: :gin}
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
      t.string :import_status
      t.timestamps
    end
    add_index :media, [:slug, :type], unique: true

  end
end
