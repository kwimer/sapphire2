class CreateMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :media, id: :uuid do |t|
      t.belongs_to :parent, polymorphic: true, type: :uuid, index: true
      t.string :type
      t.integer :number
      t.string :production_code
      # t.string :title
      # t.string :summary
      # t.string :tagline
      t.string :original_title
      t.string :original_language
      t.date :start_date
      t.date :end_date
      t.string :status
      t.string :media_type
      t.boolean :adult
      t.boolean :in_production
      t.integer :runtime

      t.jsonb :translations
      t.jsonb :external_ids, index: {using: :gin}
      t.timestamps
    end

  end
end
