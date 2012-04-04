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

end