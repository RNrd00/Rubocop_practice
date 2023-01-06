class UsersController < ApplicationController
   before_action :correct_user, only: [:edit, :update]
   before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @books2 = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path
    else
      render :edit
    end
  end

  private

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

   def correct_user
    @user = User.find(params[:id])
    @book = @user
    redirect_back(fallback_location: user_path(current_user)) unless @book == current_user
   end
  
end
