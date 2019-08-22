class PasswordResetsController < ApplicationController
  def new
  end

  def edit
  end

  def create
      @user = User.first
      @user.create_reset_digest
      email = params[:password_reset][:email]
      @user.send_password_reset_email('4434343',email)
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    # else
    #   flash.now[:danger] = "Email address not found"
    #   render 'new'
 
  end
end
