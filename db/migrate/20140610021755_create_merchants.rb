class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.text :address
      t.string :name

      t.timestamps
    end

    add_index :merchants, :name, unique: true
  end
end
