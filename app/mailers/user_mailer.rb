class UserMailer < ApplicationMailer
  def password_reset(phone, email)
    @user = User.first
    @email = email
    mail to: @email, subject: "Password reset"
  end
end