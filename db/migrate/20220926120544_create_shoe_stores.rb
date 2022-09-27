class CreateShoeStores < ActiveRecord::Migration[6.1]
  def change
    create_table :shoe_stores do |t|
      t.string :store, { index: true, null: false }
      t.string :model, { index: true, null: false }
      t.integer :inventory, index: true, null: false, default: 0

      t.timestamps
    end
  end
end
