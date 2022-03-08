class CreateInputs < ActiveRecord::Migration[5.1]
  def change
    create_table :inputs do |t|
      t.string :name
      t.string :weight
      t.integer :unit_measurement
      t.references :inventory, foreign_key: true

      t.timestamps
    end
  end
end
