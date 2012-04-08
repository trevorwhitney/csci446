module GamesHelper

  def gamez_header
    controller = params[:controller]
    if controller == "members/games"
      raw RedCloth.new("h2. My Gamez").to_html + new_game
    elsif controller == "admin/games"
      admin_gamez_header
    end
  end

  def admin_gamez_header
    count = Game.count
    raw RedCloth.new("h2. #{pluralize(count, "Total Game")}").to_html + new_game
  end

  def game_title(game)
    if current_user.nil?
      game.title
    elsif current_user.is_admin?
      link_to game.title, edit_admin_game_path(game)
    else
      if permitted_to? :edit, game
        link_to game.title, edit_members_game_path(game)
      else
        game.title
      end
    end
  end

  def new_game
    if current_user.nil?
      return
    elsif current_user.is_admin?
      link_to image_tag('add.png') + "Add a game", new_admin_game_path,
        :class => 'button'
    else
      link_to image_tag('add.png') + "Add a game", new_members_game_path,
        :class => 'button'
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

  def stats
    unless current_user.nil?
      "I've created #{pluralize(current_user.games_count, "game")}, " +
        "#{current_user.percentage_rated}% of which are rated." 
    end
  end

  def creator(f)
    if current_user.is_admin?
      render 'games/creator', :form => f
    end
  end

end