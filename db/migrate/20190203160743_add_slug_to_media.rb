class AddSlugToMedia < ActiveRecord::Migration[5.2]
  def change
    add_column :media, :slug, :string
    add_index :media, [:slug, :parent_id], unique: true
  end
end
