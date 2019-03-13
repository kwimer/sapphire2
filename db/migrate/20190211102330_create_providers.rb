class CreateProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :providers do |t|
      t.string :name
      t.string :slug, uniq: true
      t.string :code
      t.jsonb :extra_fields
    end

    create_table :provider_media do |t|
      t.belongs_to :provider, index: true
      t.belongs_to :media, polymorphic: true, index: true
      t.string :country_code
      t.integer :season_number
      t.string :external_id
      t.jsonb :prices
      t.datetime :start_date
      t.datetime :end_date
    end
    add_index :provider_media, [:provider_id, :media_type, :media_id, :season_number, :country_code], unique: true, name: :index_provider_media_on_unique

    create_table :provider_logs do |t|
      t.belongs_to :provider
      t.string :action_type, null: false
      t.string :key, null: false
      t.jsonb :data
      t.string :tmdb_id
      t.string :status
      t.timestamps
    end
    add_index :provider_logs, [:provider_id, :action_type, :key], unique: true, name: :index_provider_logs_on_unique

  end
end
