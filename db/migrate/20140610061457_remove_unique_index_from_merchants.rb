class RemoveUniqueIndexFromMerchants < ActiveRecord::Migration
  def change
    remove_index :merchants, :name
    add_index :merchants, :name
  end
end
