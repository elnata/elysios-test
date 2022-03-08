class CreateLots < ActiveRecord::Migration[5.1]
  def change
    create_table :lots do |t|
      t.string :name
      t.string :weight
      t.integer :unit_measurement
      t.references :input, foreign_key: true

      t.timestamps
    end
  end
end
