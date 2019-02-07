class CreateMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :media, id: :uuid do |t|
      t.boolean :active, null: false, default: false
      t.belongs_to :season, type: :uuid, index: true
      t.string :original_title
      t.string :original_language
      t.string :slug
      t.string :type
      t.date :start_date
      t.date :end_date
      t.string :status
      t.string :media_type
      t.integer :number
      t.jsonb :translations
      # t.string :title
      # t.string :summary
      # t.string :tagline
      t.jsonb :extra_fields
      # t.integer :season_number
      # t.integer :production_code
      t.jsonb :external_ids, index: {using: :gin}
      t.jsonb :external_scores, index: {using: :gin}
      t.timestamps
    end
    add_index :media, [:slug, :type], unique: true

  end
end
