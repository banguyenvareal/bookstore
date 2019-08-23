class PasswordResetsController < ApplicationController
  # before_action :get_phone, only: %i[edit, update]
  before_action :find_user, only: %i[edit, update]
  def new

  end

  def edit
    binding.pry
    @user = User.find_by(params[:phone])
  end

  def create
      if @user
        @user.create_reset_digest
        phone = params[:password_reset][:phone]
        email = params[:password_reset][:email]
        @user.send_password_reset_email(phone,email)
        flash[:info] = "Email sent with password reset instructions"
      else
        flash[:info] = "User not exist"
      end
      redirect_to root_path
  end

  def update
    binding.pry
    @user = User.find_by(reset_digest: params[:id])
  end

  private

  def find_user
    @user = User.find_by(phone: @phone)
  end

  def user_params
    arams.require(:user).permit(:password, :password_confirmation)
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_url
    end
  end

  private

  # def get_phone
  #   @phone = params[:phone]
  # end



end
