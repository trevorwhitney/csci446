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
      link_to "Admin", "/admin"
    else
      link_to "My Games", "/members/games"
    end
  end

  def admin_nav
    if current_user.is_admin?
      render "admin/admin_nav"
    end
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
