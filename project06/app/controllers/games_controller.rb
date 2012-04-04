class GamesController < ApplicationController

  def index
    @games = Game.paginate :per_page => 10, :page => params[:page],
      :include => [:rating, :user]
    render 'games/index'
  end

end