class UserMailer < ApplicationMailer
  def password_reset(phone, email)
    @phone = phone
    @user = User.find_by(phone: phone)
    if @user
      @email = email
      mail to: @email, subject: "Password reset"
    end
  end
end
