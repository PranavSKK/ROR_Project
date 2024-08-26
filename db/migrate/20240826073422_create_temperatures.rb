class CreateTemperatures < ActiveRecord::Migration[5.2]
  def change
    create_table :temperatures do |t|
      t.references :city, foreign_key: true
      t.date :date
      t.float :temperature

      t.timestamps
    end
  end
end
