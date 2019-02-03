class CreateCredits < ActiveRecord::Migration[5.2]
  def change
    create_table :credits, id: :uuid do |t|
      t.belongs_to :media, polymorphic: true, type: :uuid, index: true
      t.belongs_to :person, type: :uuid
      t.string :credit_type
      t.string :character
      t.string :department
      t.string :job

      t.jsonb :external_ids, index: {using: :gin}
      t.timestamps
    end

    create_table :media_credits do |t|
      t.belongs_to :media, polymorphic: true, type: :uuid, index: true
      t.belongs_to :credit, type: :uuid
      t.integer :position
    end

  end
end
