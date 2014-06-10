class AddUniqueIndexToPurchasers < ActiveRecord::Migration
  def change
    remove_index :purchasers, :name
    add_index :purchasers, :name, unique: true
  end
end
