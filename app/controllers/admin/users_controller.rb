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

  def update
    if @user.update_attributes(user_params)
      redirect_to admin_users_path, notice: "The user information was updated"
    else
      render :edit
    end
  end

  def destroy
    UserMailer.deletion(@user).deliver_later
    @user.destroy
    redirect_to root_path, notice: "The user has been deleted"
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to movies_path, notice: "An account for #{@user.firstname} has been created!"
    else
      render :new
    end
  end

  # def update
  #   respond_to do |format|
  #     if @user.update(user_params)
  #       format.html { redirect_to @user, notice: 'Movie was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @user }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  protected

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end




end
