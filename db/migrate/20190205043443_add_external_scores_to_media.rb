class AddExternalScoresToMedia < ActiveRecord::Migration[5.2]
  def change
    add_column :media, :external_scores, :jsonb
    add_index :media, :external_scores, using: :gin
  end
end
