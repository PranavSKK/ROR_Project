class AddWalletBalanceToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :wallet_balance, :integer, default: 10000
  end
end
