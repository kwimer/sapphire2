class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.belongs_to :user
      t.string :name
      t.string :slug
      t.text :description
      t.integer :list_items_count, null: false, default: 0
      t.timestamps
    end

    create_table :list_items do |t|
      t.belongs_to :list
      t.belongs_to :media, polymorphic: true, index: true
      t.text :detail
      t.integer :position
    end
    add_index :list_items, [:list_id, :media_type, :media_id], unique: true
  end
end
