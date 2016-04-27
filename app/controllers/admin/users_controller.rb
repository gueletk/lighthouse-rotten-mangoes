class Admin::UsersController < ApplicationController

  before_action :require_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]
# Methods omitted

  def require_admin
    unless current_user.admin?
      redirect_to root_path, notice: "You don't have permission to view this page"
    end
  end



  def new
    @user = User.new
  end

  def index
    @users = User.page params[:page]
  end

  def show

  end

  def edit
    # if @user.update_attributes(user_params)
    #   redirect_to users_path, notice: "The user information was updated"
    # else
    #   render :edit
    # end
  end

  def destroy
    @user.destroy
  end

  protected

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end




end
