module GamesHelper

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

end