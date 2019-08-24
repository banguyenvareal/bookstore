class PasswordResetsController < ApplicationController
  def new
  end

  def edit
    @user = User.first
  end
end
