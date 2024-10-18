class UsersController < ApplicationController
  before_action :authenticate_user!  # Ensure user is logged in

  def index
    @users = User.all  # Fetch all users (if needed)
    @loans = current_user.loans  # Fetch loans for the currently logged-in user
  end

  def show
    @user = User.find(params[:id])  # Fetch the user
    @loans = @user.loans  # Fetch loans for the specified user (if needed)
  end
end
