# app/controllers/loans_controller.rb
class LoansController < ApplicationController
  before_action :set_user
  before_action :set_loan, only: [:show, :update]

  def new
    @loan = @user.loans.build
  end

  def create
    @loan = @user.loans.build(loan_params)
    if @loan.save
      redirect_to user_loan_path(@user, @loan), notice: 'Loan requested successfully.'
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html  # Ensure this format is available for HTML requests
    end
  end

  def update
    if @loan.update(loan_params)
      redirect_to user_loan_path(@user, @loan), notice: 'Loan updated successfully.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_loan
    @loan = @user.loans.find(params[:id])
  end

  def loan_params
    params.require(:loan).permit(:amount, :interest_rate, :state)
  end
end
