class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[admin financial employee resident]

  def index
    @users = User.order('role asc')
  end

  def destroy
    @user = User.find(params[:id])
    if @user.admin? && User.admin.count == 1
      redirect_to users_path, notice: I18n.t('views.users.index.messages.deletion.failed.unique_admin')
    else
      @user.destroy
      redirect_to users_path, notice: I18n.t('views.users.index.messages.deletion.succeeded')
    end
  end

  def admin
    @user.admin!
    redirect_to users_path, notice: I18n.t('views.users.index.messages.role_change.succeeded')
  end

  def financial
    if @user.admin? && User.admin.count == 1
      redirect_to users_path, alert: I18n.t('views.users.index.messages.role_change.failed.unique_admin')
    else
      @user.financial!
      redirect_to users_path, notice: I18n.t('views.users.index.messages.role_change.succeeded')
    end
  end

  def employee
    if @user.admin? && User.admin.count == 1
      redirect_to users_path, alert: I18n.t('views.users.index.messages.role_change.failed.unique_admin')
    else
      @user.employee!
      redirect_to users_path, notice: I18n.t('views.users.index.messages.role_change.succeeded')
    end
  end

  def resident
    if @user.admin? && User.admin.count == 1
      redirect_to users_path, alert: I18n.t('views.users.index.messages.role_change.failed.unique_admin')
    else
      @user.resident!
      redirect_to users_path, notice: I18n.t('views.users.index.messages.role_change.succeeded')
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
