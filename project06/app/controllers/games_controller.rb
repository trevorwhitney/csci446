class GamesController < ApplicationController

  def index
    @games = Game.all_games(params[:page])
    render 'games/index'
  end

end