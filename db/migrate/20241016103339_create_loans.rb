class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|
      t.decimal :amount
      t.decimal :interest_rate
      t.string :state
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
