class CreateInventories < ActiveRecord::Migration[5.1]
  def change
    create_table :inventories do |t|
      t.string :name
      t.string :weight
      t.integer :unit_measurement

      t.timestamps
    end
  end
end
