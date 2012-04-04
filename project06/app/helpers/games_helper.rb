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

end