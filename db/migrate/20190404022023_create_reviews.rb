class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :record, polymorphic: true, null: false, index: true
      t.references :user
      t.integer :rating
      t.text :content
      t.timestamps
    end
  end
end