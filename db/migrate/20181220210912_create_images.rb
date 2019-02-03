class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|

      t.belongs_to :media, polymorphic: true, index: true
      t.string :image_type
      t.string :source
      t.string :key
      t.integer :width
      t.integer :height
      t.string :language

      t.jsonb :external_ids

      t.timestamps
    end

    add_index :images, :external_ids, using: :gin
  end
end
