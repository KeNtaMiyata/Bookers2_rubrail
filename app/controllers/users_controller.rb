class UsersController < ApplicationController

  def index
    @book_new = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    @book_new = Book.new
    @made_user = User.find(params[:id])
    @user = current_user
    @books = @made_user.books
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) unless current_user.id == @user.id
  end

  def update
    @user =  User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Editing successfully"
      redirect_to user_path
    else
      render :edit
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
