class UsersController < ApplicationController
  before_filter :ensure_signed_in, only: :show
  before_filter :ensure_signed_out, only: [:new, :create]
  
  def new
    render :new
  end
  
  def create
    user = User.new(user_params)
    if user.save
      sign_in_user!(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end
  
  def show
    render :show
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
