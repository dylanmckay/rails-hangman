class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id])
  end

  def index

  end

  def create
    user = User.create!(create_params)
    redirect_to user
  end

  private

  def create_params
    params.require(:user).permit(:username)
  end
end
