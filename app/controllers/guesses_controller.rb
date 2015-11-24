class GuessesController < ApplicationController

  def create
    game = Game.find(params[:game_id])
    user = User.find(game.user_id)

    guess = game.guesses.new(guess_params)

    if !guess.save
      flash.alert = "not a valid character"
    end

    redirect_to user_game_path(user,game)
  end

  private

  def guess_params
    params.require(:guess).permit(:letter)
  end
end
