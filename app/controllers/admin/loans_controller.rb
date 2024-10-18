# app/controllers/admin/loans_controller.rb
class Admin::LoansController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, except: [:confirm]
  before_action :set_loan, only: [:edit, :update, :confirm]

  def index
    @admin_wallet = 10_00_000 # Admin's wallet in paise (10L)
    @loans = Loan.all.includes(:user)
  end

  def edit
    # @loan is set via the before_action
  end

  def update
    case params[:action_type]
    when 'approve'
      if @loan.update(state: 'approved')
        redirect_to admin_loans_path, notice: 'Loan approved. Awaiting user confirmation.'
      else
        redirect_to admin_loans_path, alert: 'Failed to approve loan.'
      end
    when 'reject'
      @loan.update(state: 'rejected')
      redirect_to admin_loans_path, notice: 'Loan rejected.'
    when 'adjust'
      new_interest_rate = params[:loan][:interest_rate]
      if @loan.update(interest_rate: new_interest_rate)
        redirect_to admin_loans_path, notice: 'Interest rate updated successfully.'
      else
        render :edit, alert: 'Failed to update interest rate.'
      end
    end
  end

  # New action to handle user confirmation
  def confirm
    if params[:confirmation] == 'accept'
      ActiveRecord::Base.transaction do
        @loan.update!(state: 'open')
        current_user.wallet_balance -= @loan.amount
        @loan.user.wallet_balance += @loan.amount
        current_user.save!
        @loan.user.save!
      end
      redirect_to user_dashboard_path, notice: 'Loan opened successfully!'
    elsif params[:confirmation] == 'reject'
      @loan.update!(state: 'rejected')
      redirect_to user_dashboard_path, alert: 'Loan rejected by the user.'
    else
      redirect_to user_dashboard_path, alert: 'Invalid confirmation.'
    end
  rescue ActiveRecord::RecordInvalid
    redirect_to user_dashboard_path, alert: 'Transaction failed. Please try again.'
  end

  private

  def set_loan
    @loan = Loan.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_loans_path, alert: 'Loan not found.'
  end

  def loan_params
    params.require(:loan).permit(:amount, :interest_rate, :state)
  end

  def authorize_admin!
    redirect_to root_path, alert: 'Access denied.' unless current_user.admin?
  end
end
