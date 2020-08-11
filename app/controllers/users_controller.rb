class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_super, only: [:index, :show, :edit, :update, :destroy]
  before_action :authenticate_company, only: [:show, :edit, :update]

  def index
    @users = User.where(team_id:current_user.team_id)
  end

  def show
    @user = User.find_by(id:params[:id])
  end

  def edit
    @user = User.find_by(id:params[:id])
  end

  def update
    user = User.find_by(id:params[:id])
    if current_user == user && params[:user][:super] == "false"
      flash[:alert] = '自分の権限は変更できません。'
    else
      user.update(user_params)
    end
    redirect_to users_path
  end

  def destroy
    user = User.find_by(id:params[:id])
    if user.super == true
      flash[:alert] = '管理者アカウントは削除できません。'
    else
      user.destroy!
    end
    redirect_to users_path
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :super)
  end
  def authenticate_super
    redirect_to root_path unless current_user.super
  end
  def authenticate_company
    redirect_to root_path unless current_user.team_id == User.find_by(id:params[:id]).team_id
  end
end
