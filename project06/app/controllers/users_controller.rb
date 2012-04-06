class UsersController < ApplicationController

  def new
    @user = User.new
    @form_url = users_path
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      respond_to do |format|
        format.html { redirect_to login_url, 
          :flash => { :success => "User #{@user.username} sucessfully created."}
        }
      end
    else
      respond_to do |format|
        format.html { render :action => 'new', :template => 'admin/users/new'}
      end
    end
  end

end
