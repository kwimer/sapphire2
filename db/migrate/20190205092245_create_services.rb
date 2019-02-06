class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services, id: :uuid do |t|
      t.string :name
      t.string :slug
      t.string :service_type
      t.timestamps
    end

    create_table :media_services, id: :uuid do |t|
      t.belongs_to :media, polymorphic: true, type: :uuid, index: true
      t.belongs_to :service, type: :uuid
    end

  end
end
