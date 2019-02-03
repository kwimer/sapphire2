class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|

      t.belongs_to :media, polymorphic: true, index: true
      t.string :name
      t.string :video_type
      t.string :source
      t.string :key
      t.integer :size
      t.string :language

      t.jsonb :external_ids, index: {using: :gin}

      t.timestamps
    end
  end
end
