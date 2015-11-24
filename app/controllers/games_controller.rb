class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @user = User.find(@game.user_id)
  end

  def index
    @user = User.find(params[:user_id])
  end

  def create
    user_id = params.permit(:user_id)
    game = Game.create!(user_id)
    redirect_to user_game_url(user_id,game)
  end
end
