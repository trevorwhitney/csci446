class Members::GamesController < Members::MembersController
  before_filter :require_user

  def index
    if current_user.is_admin?
      return redirect_to admin_users_path
    end

    @games = Game.paginate :per_page => 10, :page => params[:page],
      :include => :rating
    render 'games/index'
  end

  def edit
    @game = Game.find(params[:id])
    @form_url = members_game_path
    render 'games/edit'
  end

  def update
    @game = Game.find(params[:id])

    if @game.update_attributes(params[:game])
      respond_to do |format|
        format.html { redirect_to members_games_path, 
          :success => "Game successfully updated."}
      end
    else
      respond_to do |format|
        @form_url = members_game_path
        format.html { render :action => "edit", :template => "games/edit" }
      end
    end
  end

end