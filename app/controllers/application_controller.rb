class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :current_sign_in, :signed_in?
  
  private
  def sign_in_user(user)
    puts "USER ACTIVATED? #{user.activated}"
    return false if !user.activated
    
    @current_sign_in = user.sign_ins.create!
    session[:token] = @current_sign_in.session_token
    true
  end
  
  def current_user
    return nil if current_sign_in.nil?
    return @current_user ||= current_sign_in.user
  end
  
  def current_sign_in
    @current_sign_in ||= SignIn.find_by_session_token(session[:token])
  end
  
  def signed_in?
    !!current_user
  end
  
  def sign_out!(sign_in)
    session[:token] = nil if sign_in == current_sign_in
    sign_in.destroy!
  end
  
  def ensure_signed_in
    redirect_to new_sign_in_url if !signed_in?
  end
  
  def ensure_signed_out
    redirect_to new_sign_in_url if signed_in?
  end
end
