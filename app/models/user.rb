class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :loans, dependent: :destroy

  # User roles
  enum role: { user: 'user', admin: 'admin' }

  # Wallet balance validation
  validates :wallet_balance, numericality: { greater_than_or_equal_to: 0 }
  # attr_accessor :wallet_balance  # If it's not a database column

  def admin?
    role == 'admin'
  end

  def regular_user?
    role == 'user'
  end
end
