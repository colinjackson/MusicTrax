class UsersController < ApplicationController
  before_filter :ensure_signed_in, only: :show
  before_filter :ensure_signed_out, only: [:new, :create]
  before_filter :ensure_admin, only: [:index, :destroy, :toggle_admin]
  
  def index
    render :index
  end
  
  def new
    render :new
  end
  
  def create
    user = User.new(user_params)
    if user.save
      UserMailer.activation_email(user).deliver
      flash[:errors] = ["Please check your email to activate your account!"]
      redirect_to new_sign_in_url
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end
  
  def show
    render :show
  end
  
  def destroy
    user = User.find(params[:id])
    if user.destroy
      redirect_to users_url
    else
      flash[:errors] = band.errors.full_messages
      redirect_to users_url
    end
  end
  
  def activate
    user = User.activate_with_token(params[:activation_token])
    if user.nil?
      flash[:errors] = ["Activation url didn't match any unactivated accounts!"]
      redirect_to new_sign_in_url
    elsif user.save
      sign_in_user(user)
      redirect_to user_url(user)
    else
      flash[:errors] = user.errors.full_messsages
      redirect_to new_sign_in_url
    end
  end
  
  def toggle_admin
    user = User.find(params[:id])
    user.toggle(:admin)
    if user.save
      redirect_to users_url
    else
      flash[:errors] = user.errors.full_messages
      redirect_to users_url
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
