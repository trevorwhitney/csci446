class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:create, :new]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      user = User.find_by_username(params[:user_session][:username])
      flash[:success] = "Welcome back, #{user.full_name}."
      redirect_to root_url
    else
      flash[:error] = "Could not log in."
      render :action => 'new'
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:success] = "Sucessfully logged out."
    redirect_to root_url
  end

end
