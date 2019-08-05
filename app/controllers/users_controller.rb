class UsersController < ApplicationController
  before_action :validate_user, only: %i[show edit]

  def show
    @books = get_books
    @book_requests = get_book_requests
  end

  def new
    redirect_to current_user if current_user
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t('.user_created')
      log_in @user
      redirect_to @user
    else
      flash.now[:danger] = t('.user_create_fail')
      render 'new'
    end
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:success] = t('.update_success')
      redirect_to current_user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :phone, :address, :password, :password_confirmation, :avatar
    )
  end

  def validate_user
    return if params[:id].to_i == current_user&.id

    flash[:danger] = t('not_found')
    redirect_to root_url
  end

  def get_books
    current_user.books
                .order(created_at: :desc)
                .includes(:images, :user)
                .page(params[:page]).per(4)
  end

  def get_book_requests
    current_user.book_requests
                .order(created_at: :desc)
                .includes(:book_request_images, :user)
                .page(params[:page]).per(16)
  end
end
