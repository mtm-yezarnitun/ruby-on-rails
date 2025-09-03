class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
  @users = User.all.order(role: :desc, created_at: :asc)
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "User updated successfully."
    else
      render :edit
    end
  end

  def destroy
    if @user == current_user
      redirect_to admin_users_path, alert: "You can't delete yourself!"
      return
    end

    @user.destroy
    redirect_to admin_users_path, notice: "User deleted successfully."
  end

  private

  def authorize_admin!
    redirect_to root_path, alert: "Not authorized" unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :user_name, :role)
  end
end
