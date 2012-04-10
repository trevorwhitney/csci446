module UsersHelper

  def username_text_field(form)
    if current_user.nil?
      form.text_field :username
    elsif current_user.is_admin?
      form.text_field :username
    else
      form.text_field :username, :disabled => true
    end
  end

  def user_roles_li(form)
    unless current_user.nil?
      if current_user.is_admin?
        render 'users/roles_li', :form => form
      end
    end
  end

  def user_roles
    current_user.role_symbols.compact.join(", ").to_s.humanize
  end

  def register
    unless current_user
      render 'users/register'
    end
  end

  def recaptcha(form)
    if current_user.nil?
      render 'users/recaptcha', :form => form
    end
  end

  def login_link
    link_to image_tag('door_in.png') + "Login", login_path, :class => 'button'
  end

  def logout_link
    link_to image_tag('door_out.png') +  "Logout", logout_path, :class => 'button'
  end

  def register_link
    link_to image_tag('user_add.png') + "Register", register_path, :class => 'button'
  end

  def delete(user)
    if current_user.is_admin?
      render 'users/delete', :user => user
    end
  end

  def add_user_link
    if current_user.is_admin?
      link_to image_tag('add.png') + "Create new user", new_admin_user_path,
        :class => 'button'
    end
  end

end
