class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos, id: :uuid do |t|

      t.belongs_to :media, polymorphic: true, type: :uuid, index: true
      t.boolean :primary, default: false, null: false
      t.string :name
      t.string :video_type
      t.string :source
      t.string :key
      t.integer :size
      t.string :language
      t.jsonb :external_ids, index: {using: :gin}

      t.timestamps
    end
    add_index :videos, [:source, :key], unique: true
  end
end
