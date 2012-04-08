module ApplicationHelper

  def currently_logged_in_user
    if current_user.is_admin?
      link_to current_user.full_name, admin_user_path(current_user)
    else
      link_to current_user.full_name, members_profile_path
    end
  end

  def current_role_link
    if current_user.is_admin?
      link_to image_tag('cog.png') + "Admin", "/admin", :class => 'button'
    else
      link_to image_tag('controller.png') + "My Games", "/members/games", 
        :class => 'button'
    end
  end

  def admin_nav
    if current_user.is_admin?
      render "admin/admin_nav"
    end
  end

  def admin_nav_games_link
    link_to image_tag('controller.png') + "Games", "/admin", 
      :class => 'button'
  end

  def admin_nav_users_link
    link_to image_tag('user.png') + "Users", "/admin/users",
      :class => 'button'
  end

  def admin_nav_roles_link
    link_to image_tag('group.png') + "Roles", "/admin/roles", 
      :class => 'button'
  end

  def render_flash
    if flash.present?
      render 'flash/messages'
    end
  end

  def show_success
    raw RedCloth.new("p(success). #{flash[:success]}").html
  end

  def show_error
    raw RedCloth.new("p(error). #{flash[:error]}").html
  end

  def show_notice
    raw RedCloth.new("p(notice). #{flash[:notice]}").html
  end
  
end
