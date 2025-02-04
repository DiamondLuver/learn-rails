class CreateVendors < ActiveRecord::Migration[8.0]
  def change
    create_table :vendors do |t|
      t.references :user, null: false, foreign_key: true
      t.string :profile_picture
      t.boolean :status
      t.float :commission_rate

      t.timestamps
    end
  end
end
