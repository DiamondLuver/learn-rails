class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.string :photo
      t.text :description
      t.references :vendor, null: false, foreign_key: true
      t.float :quantity, default: 1

      t.timestamps
    end
  end
end
