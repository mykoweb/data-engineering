class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.text :description
      t.decimal :price
      t.references :merchant

      t.timestamps
    end
  end
end
