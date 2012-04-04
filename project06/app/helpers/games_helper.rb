module GamesHelper

  def games_nav
    controller = params[:controller]
    if controller == "members/games" || controller == :admin
      raw RedCloth.new("h2. My Gamez").to_html + new_game
    end
  end

  def game_title(game)
    if current_user.nil?
      game.title
    elsif current_user.is_admin?
      link_to game.title, edit_admin_game_path(game)
    else
      link_to game.title, edit_members_game_path(game)
    end
  end

  def new_game
    if current_user.nil?
      return
    elsif current_user.is_admin?
      link_to "Add a game", new_admin_game_path
    else
      link_to "Add a game", new_members_game_path
    end
  end

  def created_at_and_by(game)
    if game.user == current_user
      name = "me"
    else
      name = game.user.full_name
    end

    "#{game.created_at.strftime("%b. %-d, %Y")} by #{name}"
  end

end