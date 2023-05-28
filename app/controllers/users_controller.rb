class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[admin financial employee resident]

  def index
    @users = User.order('role asc')
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: I18n.t('views.users.index.messages.deletion.succeeded')
  end

  def admin
    @user.admin!
    redirect_to users_path, notice: I18n.t('views.users.index.messages.role_change.succeeded')
  end

  def financial
    @user.financial!
    redirect_to users_path, notice: I18n.t('views.users.index.messages.role_change.succeeded')
  end

  def employee
    @user.employee!
    redirect_to users_path, notice: I18n.t('views.users.index.messages.role_change.succeeded')
  end

  def resident
    @user.resident!
    redirect_to users_path, notice: I18n.t('views.users.index.messages.role_change.succeeded')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
