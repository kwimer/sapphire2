class CreateFestivals < ActiveRecord::Migration[5.2]
  def change
    create_table :festivals do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end

    create_table :awards do |t|
      t.belongs_to :movie, index: true
      t.belongs_to :festival
      t.integer :year
      t.string :award_type
      t.string :award_name
    end

  end
end
