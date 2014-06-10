class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :quantity
      t.references :purchaser
      t.references :item

      t.timestamps
    end
  end
end
