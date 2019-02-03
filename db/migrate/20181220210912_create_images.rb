class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images, id: :uuid do |t|

      t.belongs_to :media, polymorphic: true, type: :uuid, index: true
      t.boolean :primary, null: false, default: false
      t.string :image_type
      t.string :source
      t.string :key
      t.integer :width
      t.integer :height
      t.string :language

      t.timestamps
    end

    add_index :images, [:source, :key], unique: true
  end
end
