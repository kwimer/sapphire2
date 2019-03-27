class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t|
      t.belongs_to :user, null: false
      t.references :actionable,   polymorphic: true, null: false
      t.string :scope
      t.timestamps
    end
    add_index :actions, [:user_id, :scope]
    add_index :actions, [:actionable_id, :actionable_type, :scope]
  end
end
