class Loan < ApplicationRecord
  belongs_to :user

  validates :amount, :interest_rate, presence: true

  # Possible loan states
  enum state: {
    requested: 'requested',
    approved: 'approved',
    open: 'open',
    closed: 'closed',
    rejected: 'rejected',
    waiting_for_adjustment_acceptance: 'waiting_for_adjustment_acceptance',
    readjustment_requested: 'readjustment_requested'
  }
end
