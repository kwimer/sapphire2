class CreateAwards < ActiveRecord::Migration[5.2]
  def change
    create_table :awards, id: :uuid do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end

    create_table :media_awards do |t|
      t.belongs_to :media, polymorphic: true, type: :uuid, index: true
      t.belongs_to :award, type: :uuid
      t.integer :year
      t.string :award_type
      t.string :award_name
    end

  end
end
