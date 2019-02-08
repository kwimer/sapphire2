class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.belongs_to :parent, index: true
      t.string :name
      t.string :code, unique: true
    end

    create_table :media_categories do |t|
      t.belongs_to :media, polymorphic: true, index: true
      t.belongs_to :category
    end

    add_index :media_categories, [:category_id, :media_type, :media_id], unique: true, name: :index_media_categories_on_unique

  end
end
