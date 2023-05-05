class UsersController < ApplicationController
  before_action :set_user, only: %i[admin financial employee resident]

  def index
    @users = User.order('role asc')
  end

  def admin
    @user.admin!
    redirect_to users_path
  end

  def financial
    @user.financial!
    redirect_to users_path
  end

  def employee
    @user.employee!
    redirect_to users_path
  end

  def resident
    @user.resident!
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
