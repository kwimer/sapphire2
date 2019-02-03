class AddSlugToMedia < ActiveRecord::Migration[5.2]
  def change
    add_column :media, :slug, :string
    add_index :media, :slug, unique: true
  end
end
