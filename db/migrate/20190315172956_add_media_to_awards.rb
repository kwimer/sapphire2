class AddMediaToAwards < ActiveRecord::Migration[5.2]
  def change
    drop_table :awards
    create_table :awards do |t|
      t.belongs_to :media, index: true
      t.belongs_to :festival
      t.integer :year
      t.string :award_type
      t.string :award_name
    end
  end
end
