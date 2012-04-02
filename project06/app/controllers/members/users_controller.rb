class Members::UsersController < Members::MembersController
  before_filter :require_user

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to members_profile_url, 
          notice: "Your profile was sucessfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = current_user
    @form_url = members_update_profile_path(current_user)
    render 'users/edit'
  end

  def show
    @user = current_user
    @edit_user_path = members_edit_profile_path
    render 'users/show'
  end

end
