class UsersController < ApplicationController
  before_filter :require_no_user

  def new
    @user = User.new
    @form_url = users_path
  end

  def create
    @user = User.new(params[:user])

    if @user.valid? && verify_recaptcha(:model => @user, 
      :message => "reCAPTCHA is not correct.")
      @user.save
      respond_to do |format|
        format.html { redirect_to root_url, 
          :flash => { :success => "User #{@user.username} sucessfully created."}
        }
      end
    else
      @form_url = users_path
      respond_to do |format|
        format.html { render :action => 'new', :template => 'users/new' }
      end
    end
  end

end
