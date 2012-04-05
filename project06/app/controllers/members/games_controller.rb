class Members::GamesController < Members::MembersController
  before_filter :require_user
  filter_access_to :edit, :update, :attribute_check => true
  filter_access_to :index, :new, :create

  def index
    if current_user.is_admin?
      return redirect_to admin_users_path
    end

    @games = Game.users_games(current_user, params[:page])
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
        format.html do
          redirect_to members_games_path, 
           :flash => {:success => "Successfully updated #{@game.title}."}
        end
      end
    else
      respond_to do |format|
        @form_url = members_game_path
        format.html { render :action => "edit", :template => "games/edit" }
      end
    end
  end

  def new
    @game = Game.new
    @form_url = members_games_path
    render 'games/new'
  end

  def create
    @game = Game.new(params[:game])

    if @game.save
      respond_to do |format|
        format.html do 
          redirect_to members_games_path,
            :flash => {:success => "Sucessfully added #{@game.title}."}
        end
      end
    else
      respond_to do |format|
        @form_url = members_games_path
        format.html do
          render :action => "new", :template => "games/new"
        end
      end
    end
  end

end