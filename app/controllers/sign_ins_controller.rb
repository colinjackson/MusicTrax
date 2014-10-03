class SignInsController < ApplicationController
  def new
    render :new
  end
  
  def create
    user = User.find_by_credentials(user_params)
    if user
      sign_in_user(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = ["Bad user_name/password combo!"]
      render :new
    end
  end
  
  def destroy
    sign_in = SignIn.find(params[:id])
    sign_out!(sign_in)
    redirect_to :back
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
