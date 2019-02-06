class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories, id: :uuid do |t|
      t.belongs_to :parent, type: :uuid, index: true
      t.string :name
      t.string :slug
    end

    add_index :categories, [:slug, :parent_id], unique: true

    create_table :media_categories do |t|
      t.belongs_to :media, polymorphic: true, type: :uuid, index: true
      t.belongs_to :category, type: :uuid
    end

  end
end
